# == Schema Information
#
# Table name: businesses
#
#  id                     :integer          not null, primary key
#  name                   :string
#  street                 :string
#  zipcode                :string
#  city                   :string
#  url                    :string
#  telephone              :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  description            :text
#  business_category_id   :integer
#  latitude               :float
#  longitude              :float
#  facebook               :string
#  twitter                :string
#  instagram              :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  leader_first_name      :string
#  leader_last_name       :string
#  leader_description     :text
#  active                 :boolean          default(FALSE), not null
#  online                 :boolean          default(FALSE), not null
#  leader_phone           :string
#  leader_email           :string
#  shop                   :boolean          default(TRUE), not null
#  itinerant              :boolean          default(FALSE), not null
#  picture                :string
#  leader_picture         :string
#  logo                   :string
#  like                   :integer          default(0)
#  unlike                 :integer          default(0)
#  link_video             :string
#  supervisor             :boolean          default(FALSE)
#  supervisor_id          :integer
#  admin                  :boolean          default(FALSE), not null
#
# Indexes
#
#  index_businesses_on_business_category_id  (business_category_id)
#  index_businesses_on_email                 (email) UNIQUE
#  index_businesses_on_reset_password_token  (reset_password_token) UNIQUE
#

class Business < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable
  belongs_to :business_category

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, :allow_destroy => true, :reject_if => :all_blank
  has_many :addresses_shop, -> { shop }, class_name: "Address"
  # has_many :addresses_itinerant, -> { today }, class_name: "Address"
  has_many :addresses_for_map, -> { for_map_load }, class_name: "Address"

  has_many :perks, dependent: :destroy
  has_many :perks_in_time, -> { in_time }, class_name: "Perk"
  has_many :perks_flash_in_time, -> { flash_in_time }, class_name: "Perk"
  has_many :labels
  has_many :timetables, through: :addresses
  has_one  :main_address, -> { main }, class_name: "Address"

  belongs_to :manager, class_name: 'Business', foreign_key: 'supervisor_id'
  has_many :businesses, class_name: 'Business', foreign_key: 'supervisor_id'
  has_many :businesses_perks, through: :businesses, source: :perks
  has_many :businesses_perks_uses, through: :businesses_perks, source: :uses
  has_many :members, class_name: 'User', foreign_key: 'supervisor_id'

  scope :active, -> { where(active: true) }
  scope :for_map, -> { where('businesses.shop = ? or businesses.itinerant = ?', true, true) }
  scope :shop, -> { where(shop: true) }
  scope :itinerant, -> { where(itinerant: true) }
  scope :supervisor, -> { where(supervisor: true) }
  scope :admin, -> { where(admin: true) }
  scope :supervisor_not_admin, -> { where('supervisor = ? and admin = ?', true, false) }

  validates :email, presence: true, uniqueness: true
  validates :business_category_id, presence: true, unless: :supervisor
  validates :name, presence: true
  validates :url, format: { with: /\Ahttps?:\/\/[\S]+/, message: "Votre URL doit commencer par http:// ou https://" }, allow_blank: true

  validates_size_of :picture, maximum: 2.megabytes,
    message: "Cette image dépasse 2 MG !", if: :picture_changed?
  mount_uploader :picture, PictureUploader

  validates_size_of :leader_picture, maximum: 1.megabytes,
    message: "Cette image dépasse 1 MG !", if: :leader_picture_changed?
  mount_uploader :leader_picture, PictureUploader

  validates_size_of :logo, maximum: 1.megabytes,
    message: "Cette image dépasse 1 MG !", if: :logo_changed?
  mount_uploader :logo, PictureUploader

  geocoded_by :address

  after_validation :geocode, if: :address_changed?

  before_save :controle_geocode!, :assign_supervisor, if: :address_changed?

  after_create :create_code_partner, :send_registration_slack, :subscribe_to_newsletter_business

  after_save :update_data_intercom
  after_save :send_activation_slack, if: :active_changed?


  def perks_uses_count
    perks.reduce(0) { |sum, perk| sum + perk.uses.used.count }
  end

  def perks_views_count
    perks.reduce(0) { |sum, perk| sum + perk.nb_views.to_i }
  end

  def perks_new_users
    perks.reduce(0) { |sum, perk| sum + perk.uses.used.select(:user_id).distinct.count }
  end

  def causes_count
    0
  end

  def amount_donation
    0
  end

  def address_changed?
    street_changed? || zipcode_changed? || city_changed?
  end

  def supervising?(id)
    return false unless id.present?
    self.admin || Business.find(id).manager == self
  end

  def collection_supervising
    return self.businesses unless self.admin
    Business.all
  end

  private

  def address
    "#{street}, #{zipcode} #{city}"
  end

  # def send_registration_email
  #   BusinessMailer.registration(self).deliver_now
  # end

  def create_code_partner
    Partner.new.create_code_partner_business(self.name, self.email)
  end

  def send_registration_slack
    message = "#{name}, *#{city}*, a rejoint la communauté !"
    send_message_to_slack(ENV['SLACK_WEBHOOK_BUSINESS_URL'], message)
  end

  def send_activation_slack
    return unless active
    message = "*#{name}* a été activé !"
    send_message_to_slack(ENV['SLACK_WEBHOOK_BUSINESS_URL'], message)
  end

  def subscribe_to_newsletter_business
    if Rails.env.production?
      SubscribeToNewsletterBusiness.new(self).run
    end
  end

  def update_data_intercom
    if active_changed? or leader_first_name_changed? or city_changed? or picture_changed? or supervisor_changed?  or supervisor_id_changed?
      # UPDATE CUSTOM ATTRIBUTES ON INTERCOM
      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
      begin
        user = intercom.users.find(:user_id => 'B'+id.to_s)
        user.custom_attributes["user_active"] = self.active
        user.custom_attributes["first_name"] = self.leader_first_name
        user.custom_attributes["city"] = self.city
        user.custom_attributes["zipcode"] = self.zipcode
        user.custom_attributes["picture_url"] = self.picture.url
        user.custom_attributes["manager"] = self.manager.name if self.manager.present?
        user.custom_attributes["supervisor"] = self.supervisor
        intercom.users.save(user)
      rescue Intercom::IntercomError => e
        puts e
      end
    end
  end

  def controle_geocode!
    while Business.where('id != ? and latitude = ? and longitude = ?', self.id, latitude, longitude).count > 0
      self.latitude -= 0.0001
      self.longitude += 0.0001
    end
  end

  def assign_supervisor
    self.manager = Business.supervisor_not_admin.near([self.latitude, self.longitude], 10).first
  end

end
