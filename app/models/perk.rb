# == Schema Information
#
# Table name: perks
#
#  id                :integer          not null, primary key
#  name              :string
#  business_id       :integer
#  description       :text
#  times             :integer          default(0)
#  start_date        :datetime
#  end_date          :datetime
#  active            :boolean          default(TRUE), not null
#  perk_code         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  nb_views          :integer          default(0)
#  appel             :boolean          default(FALSE), not null
#  durable           :boolean          default(FALSE), not null
#  flash             :boolean          default(FALSE), not null
#  perk_detail_id    :integer
#  deleted           :boolean          default(FALSE), not null
#  all_day           :boolean          default(FALSE), not null
#  picture           :string
#  text_notification :string
#  send_notification :boolean          default(FALSE)
#  offer             :boolean          default(FALSE), not null
#  value             :boolean          default(FALSE), not null
#  percent           :boolean          default(FALSE), not null
#  amount            :integer
#
# Indexes
#
#  index_perks_on_business_id     (business_id)
#  index_perks_on_perk_detail_id  (perk_detail_id)
#
# Foreign Keys
#
#  fk_rails_5797f2b98a  (business_id => businesses.id)
#

class Perk < ApplicationRecord

  belongs_to :business
  has_many :uses, dependent: :destroy
  belongs_to :perk_detail

  scope :active, -> { where(active: true) }
  scope :flash, -> { where(flash: true) }
  scope :undeleted, -> { where(deleted: false) }
  scope :permanent, -> { where('perks.active = ? and (perks.durable = ? or perks.appel = ?)', true, true, true) }
  scope :in_time, -> { where('perks.active = ? and (perks.durable = ? or perks.appel = ? or (perks.flash = ? and perks.start_date <= ? and perks.end_date >= ?))', true, true, true, true, Time.now, Time.now) }
  scope :flash_in_time, -> { where('perks.active = ? and perks.flash = ? and perks.start_date <= ? and perks.end_date >= ?', true, true, Time.now, Time.now) }

  extend TimeSplitter::Accessors
  split_accessor :start_date, :end_date

  validates :name, presence: true, length: { maximum: 35 }
  validate :name_uniqueness, if: :name_changed?
  validates :description, presence: true, length: { maximum: 220 }
  validates :perk_detail_id, presence: true
  validates :times, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validate :dates_required_if_flash
  validate :start_date_cannot_be_greater_than_end_date
  validates :perk_code, length: { in: 5..15 }, format: { with: /\A[A-Za-z0-9]+\z/, message: "Le code du bon plan ne peut contenir que des lettres et des chiffres" }, if: :perk_code_needed?
  validate :perk_code_uniqueness, if: :perk_code_changed?

  validates_size_of :picture, maximum: 2.megabytes,
    message: "Cette image dépasse 2 MG !", if: :picture_changed?
  mount_uploader :picture, PictureUploader

  after_create :send_registration_slack, :update_data_intercom
  after_save :update_data_intercom, if: :active_changed?
  after_save :send_push_notification, if: :send_notification_changed?
  after_save :send_change_to_slack
  after_destroy :update_data_intercom

  def update_nb_view!
    self.increment!(:nb_views)
  end

  def perk_usable?(user)
    if self.durable
      true
    elsif self.appel
      user.uses.used.where(perk_id: self.id).count == 0
    elsif self.flash
      self.times == 0 || Use.used.where(perk_id: self.id).count < self.times
    end
  end

  def perk_in_time?
    if self.flash
      (self.start_date <= Time.now && self.end_date >= Time.now) && (self.times == 0 || Use.used.where(perk_id: self.id).count < self.times)
    else
      true
    end
  end

  def deleted!
    self.update(active: false, deleted: true)
  end

  private

  def perk_code_needed?
    name = PerkDetail.find(self.perk_detail_id).name
    name == "online" || name == "email"
  end

  def dates_required_if_flash
    if flash
      if !start_date.present?
        errors.add(:start_date, "La date de début est obligatoire pour un bon plan flash.")
      elsif all_day
        if end_date.present?
          self.start_date = start_date.change(hour: 0, min: 0)
          self.end_date = start_date.change(hour: 23, min: 59)
        elsif
          self.end_date = end_date.change(min: 0)
        end
      elsif !end_date.present?
        errors.add(:end_date, "La date de fin est obligatoire pour un bon plan flash.")
      end
    end
  end

  def start_date_cannot_be_greater_than_end_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "La date de fin ne doit pas être antérieure à la date de début.")
    end
  end

  def send_registration_slack
    message = "#{self.business.name} a créé un nouveau bon plan *" + perk_type(self.appel, self.durable, self.flash) + "* : #{name} : #{description}"
    send_message_to_slack(ENV['SLACK_WEBHOOK_PERK_URL'], message)
  end

  def send_change_to_slack
    if ( name_changed? && name_was.present? ) || ( description_changed? && description_was.present? )
      message = "#{self.business.name} a changé son bon plan *" + perk_type(self.appel, self.durable, self.flash) + "* : #{name} : #{description}"
      send_message_to_slack(ENV['SLACK_WEBHOOK_PERK_URL'], message)
    end
  end

  def name_uniqueness
    if name.present?
      name.upcase!
      errors.add(:name, "Ce nom de bon plan est déjà utilisé !") if Perk.where(name: self.name, deleted: false).where(business_id: self.business_id).count > 0
    end
  end

  def perk_code_uniqueness
    if perk_code.present?
      perk_code.upcase!
      errors.add(:perk_code, "Ce code n'est pas disponible !") if Perk.where(perk_code: self.perk_code, deleted: false).where(business_id: self.business_id).count > 0
    end
  end

  def update_data_intercom
    # UPDATE CUSTOM ATTRIBUTES ON INTERCOM
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    begin
      user = intercom.users.find(:user_id => 'B'+self.business_id.to_s)
      user.custom_attributes[:perks_all] = Business.find(self.business_id).perks.count
      user.custom_attributes[:perks_active] = Business.find(self.business_id).perks.active.count
      intercom.users.save(user)

      if :after_create
         intercom.events.create(
          event_name: "new-perk",
          created_at: Time.now.to_i,
          user_id: 'B'+self.business_id.to_s,
          email: self.business.email,
          metadata: {
            perk_id: self.id,
            perk_type: perk_type(self.appel, self.durable, self.flash),
            title: self.name,
            description: self.description,
            picture_url: self.picture.url,
            start_date: self.start_date,
            end_date: self.end_date,
            times: self.times
          }
        )
      end

    rescue Intercom::IntercomError => e
      puts e
    end
  end

  def send_push_notification

    if send_notification_changed? && send_notification
      params = {
        app_id: ENV['ONESIGNAL_APP_ID'],
        # template_id: '033eae5c-aa46-4e41-a3f7-f6cd4211a9fc',
        headings: {"en" => "Un tout nouveau bon plan pour #{self.business.name} 😊👏"},
        contents: {"en" => "#{self.text_notification}"},
        included_segments: ["All"],
        chrome_web_icon: self.picture.url(:thumb)
      }

      begin
        response = OneSignal::Notification.create(params: params)
        notification_id = JSON.parse(response.body)["id"]
      rescue OneSignal::OneSignalError => e
        puts "--- OneSignalError  :"
        puts "-- message : #{e.message}"
        puts "-- status : #{e.http_status}"
        puts "-- body : #{e.http_body}"
      end
    end
   end

  def active?
    if flash
      end_date < DateTime.now
    else
      active
    end
  end

  protected

  def perk_type(appel, durable, flash)
      return "BIENVENUE" if self.appel
      return "DURABLE" if self.durable
      return "FLASH" if self.flash
  end

end
