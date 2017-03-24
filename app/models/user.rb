# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  provider               :string
#  uid                    :string
#  name                   :string
#  token                  :string
#  token_expiry           :datetime
#  admin                  :boolean          default(FALSE), not null
#  birthday               :datetime
#  nationality            :string
#  country_of_residence   :string
#  mangopay_id            :string
#  card_id                :string
#  cause_id               :integer
#  member                 :boolean          default(FALSE), not null
#  subscription           :string
#  trial_done             :boolean          default(FALSE), not null
#  date_subscription      :datetime
#  date_last_payment      :datetime
#  active                 :boolean          default(TRUE), not null
#  street                 :string
#  zipcode                :string
#  city                   :string
#  latitude               :float
#  longitude              :float
#  date_end_partner       :date
#  code_partner           :string
#  date_support           :date
#  amount                 :integer
#  date_stop_subscription :datetime
#  picture                :string
#  ambassador             :boolean          default(FALSE)
#  onesignal_id           :string
#  supervisor_id          :integer
#
# Indexes
#
#  index_users_on_cause_id              (cause_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_130d5504e9  (cause_id => causes.id)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  belongs_to :cause
  belongs_to :supervisor, class_name: 'Business', foreign_key: 'supervisor_id'
  has_many :uses
  has_many :payments, dependent: :destroy
  has_many :user_histories
  has_many :beneficiaries

  scope :member, -> { where(member: true) }
  scope :member_should_payin, lambda {|day| where('users.member = ? and (users.code_partner is null or users.code_partner = ?) and users.subscription = ? and users.date_last_payment between ? and ?', true, "", "M", (Time.now - 1.month - day.day).beginning_of_day,  (Time.now - 1.month - day.day).end_of_day) }
  scope :member_on_trial_should_payin, lambda {|day| where('users.member = ? and users.code_partner is not null and users.code_partner <> ? and users.date_end_partner = ?', true, "", Time.now + day.day) }

  validates :email, presence: true, uniqueness: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :city, presence: true

  validate :code_partner?, if: :code_partner_changed?

  validates_size_of :picture, maximum: 2.megabytes,
    message: "Cette image dépasse 2 MG !", if: :picture_changed?

  mount_uploader :picture, PictureUploader

  geocoded_by :address

  after_validation :geocode, if: :address_changed?

  before_create :default_cause_id!

  before_save :subscription!, if: :subscription_changed?
  before_save :subscription!, if: :code_partner_changed?
  before_save :date_support!, if: :cause_id_changed?

  before_save :assign_supervisor, if: :address_changed?

  after_save :create_partner_for_third_use_code_partner, if: :code_partner_changed?
  after_save :send_code_partner_slack, if: :code_partner_changed?
  after_save :save_history

  after_commit :update_data_intercom

  after_create :send_registration_slack, :subscribe_to_newsletter_user, :create_event_amplitude, :save_onesignal_id

  def self.find_for_google_oauth2(access_token, signed_in_resourse=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid).first

    if user
      return user
    else
      registred_user = User.where(:email => access_token.email).first
      if registred_user
        return registred_user
      else
        user = User.create(
          name: data['name'],
          first_name: data['first_name'],
          last_name: data['last_name'],
          provider: access_token.provider,
          email: data['email'],
          uid: access_token.uid,
          picture: data.image,
          password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resourse=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid).first
    if user
      return user
    else
      registred_user = User.where(:email => data.email).first
      if registred_user
        return registred_user
      else
        user = User.create(
          name: access_token.extra.raw_info.name || data.email,
          first_name: access_token.extra.raw_info.first_name,
          last_name: access_token.extra.raw_info.last_name,
          city: access_token.extra.raw_info.location.name.present? ? access_token.extra.raw_info.location.name.split(",").first : nil,
          provider: access_token.provider,
          email: data.email,
          uid: access_token.uid,
          picture: data.image,
          password: Devise.friendly_token[0,20],
        )
      end
    end
  end

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

  def should_payin?
    ( !self.code_partner.present? && ( ( self.subscription == "M" && ( !self.date_last_payment.present? || ( self.date_last_payment < Time.now - 1.month ) ) ) ||
    ( self.subscription == "Y" && ( !self.date_last_payment.present? || ( self.date_last_payment < Time.now - 12.month ) ) ) ) ||
    ( self.code_partner.present? && self.date_end_partner < Time.now ) )
  end

  def find_name_or_email?
    self.first_name + " " + self.last_name || self.name || self.email
  end

  def member!
    self.member = true
    self.date_stop_subscription = nil
    self.save
  end

  def trial_done?
    if self.code_partner.present? && !self.trial_done
      self.trial_done = true
      return self.save
    end
    return false
  end

  def stop_subscription!
    self.member = false
    self.date_stop_subscription = Time.now
    self.subscription = nil
    self.amount = nil
    self.date_last_payment = nil
    code_partner_save = self.code_partner
    self.code_partner = nil
    self.date_end_partner = nil
    self.save
    # SEND EVENT TO INTERCOM
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    begin
      intercom.events.create(
        event_name: "stop-subscription",
        created_at: Time.now.to_i,
        user_id: self.id,
        email: self.email
      )
    rescue Intercom::IntercomError => e
      puts e
    end

    #SEND EVENT TO SLACK
    message =  find_name_or_email?
    message += code_partner_save.present? ? " a résilié sa période d'essai." : " a résilié son abonnement."
    message += " |" + self.email + "|"
    send_message_to_slack(ENV['SLACK_WEBHOOK_USER_URL'], message)
  end

  private

  def subscription!
    # IF NOT EXIST, CREATE NEW USER NATURAL FOR MANGOPAY
    if !self.mangopay_id.present?
      @mangopay_user = MangopayServices.new(self).create_mangopay_natural_user
      self.mangopay_id = @mangopay_user["Id"]
    end
    self.date_subscription = Time.now if subscription_was == nil
    self.member = true if code_partner.present?
  end

  def date_support!
    self.date_support = Time.now
  end

  def code_partner?
    if code_partner.present?
      if !@partner = Partner.find_by_code_partner(code_partner.upcase)
        # Code_partner not exist
        errors.add(:code_partner, "Code promotionnel inconnu")
      elsif @partner.promo && ( ( @partner.date_start_promo.present? && @partner.date_start_promo > Time.now ) || ( @partner.date_end_promo.present? && @partner.date_end_promo < Time.now ) )
        # Code_partner out of date
        errors.add(:code_partner, "Code promotionnel non disponible à ce jour")
      elsif @partner.times != 0 && UserHistory.where(code_partner: code_partner.upcase).select(:user_id).distinct.count >= @partner.times
        # Control use count
        errors.add(:code_partner, "Code promotionnel épuisé")
      elsif @partner.shared && @partner.user_id == id
        # Code_partner to shared (except for user)
        errors.add(:code_partner, "Code promotionnel réservé aux autres utilisateurs")
      elsif @partner.exclusive && @partner.user_id != id
        # Code_partner exclusive (only for user)
        errors.add(:code_partner, "Code promotionnel exclusif non autorisé")
      elsif self.user_histories.where(code_partner: code_partner.upcase).count != 0
        # Control already use
        errors.add(:code_partner, "Code promotionnel déjà utilisé")
      else
        # Code_partner valid
        self.code_partner.upcase!
        # Trial start after pay period if exist
        if date_last_payment.present? && ( ( subscription == "M" && date_last_payment + 1.month > Time.now ) || ( subscription == "Y" && date_last_payment + 1.year > Time.now ) )
            start_date = date_last_payment + 1.month if subscription == "M"
            start_date = date_last_payment + 1.year if subscription == "Y"
        else
          start_date = Time.now
        end
        self.date_end_partner = start_date + Partner.find_by_code_partner(self.code_partner).nb_month.month
      end
    end
  end

  def address_changed?
    street_changed? || zipcode_changed? || city_changed?
  end

  def address
    "#{street}, #{zipcode} #{city}"
  end

  def default_cause_id!
    if !self.cause_id.present?
      self.cause_id = ENV['CAUSE_ID_CFORGOOD']
    end
  end

  def send_registration_slack
    message = find_name_or_email?
    message += ", *#{city}*," if city.present?
    message += " a rejoint la communauté !"
    send_message_to_slack(ENV['SLACK_WEBHOOK_USER_URL'], message)
  end

  def send_code_partner_slack
    if self.code_partner.present?
      message = find_name_or_email? + " a utilisé le code partenaire : #{self.code_partner}"
      send_message_to_slack(ENV['SLACK_WEBHOOK_USER_URL'], message)
    end
  end

  def subscribe_to_newsletter_user
    if Rails.env.production?
      SubscribeToNewsletterUser.new(self).run
    end
  end

  def create_event_amplitude
    # Configure your Amplitude API key
    AmplitudeAPI.api_key = ENV["AMPLITUDE_API_KEY"]

    event = AmplitudeAPI::Event.new({
      user_id: self.id,
      event_type: "SIGNUP_USER",
      user_properties: {
        user_type: "user",
        city: self.city
      }
    })
    AmplitudeAPI.track(event)
  end

  def update_data_intercom
    # UPDATE CUSTOM ATTRIBUTES ON INTERCOM

    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    promo = Partner.find_by_code_partner(self.code_partner).try(:promo) || false
    begin
      user = intercom.users.find(:user_id => self.id)
      user.custom_attributes["user_type"] = 'user'
      user.custom_attributes["first_name"] = self.first_name
      user.custom_attributes['city'] = self.city
      user.custom_attributes['zipcode'] = self.zipcode
      user.custom_attributes["user_active"] = self.active
      user.custom_attributes["user_cause"] = self.cause.name
      user.custom_attributes["user_member"] = self.member
      user.custom_attributes['code_partner'] = self.code_partner
      user.custom_attributes['code_promo'] = promo
      user.custom_attributes['date_end_trial'] = self.date_end_partner
      user.custom_attributes['ambassador'] = self.ambassador
      intercom.users.save(user)
    rescue Intercom::IntercomError => e
      begin
        user = intercom.users.create(
          :user_id => self.id,
          :email => self.email,
          :name => self.name,
          :created_at => created_at,
          :custom_data => {
            'user_type' => 'user',
            'first_name' => self.first_name,
            'city' => self.city,
            'zipcode' => self.zipcode,
            'user_active' => self.active,
            'user_cause' => self.cause.name,
            'user_member' => self.member,
            'code_partner' => self.code_partner,
            'code_promo' => promo,
            'date_end_trial' => self.date_end_partner,
            'ambassador' => self.ambassador
          })
        intercom.users.save(user)
      rescue Intercom::IntercomError => e
        puts e
      end
    end
  end

  def save_history
    if member_changed? || subscription_changed? || date_stop_subscription_changed? || amount_changed? || ( code_partner_changed? && ( code_partner_was.present? || code_partner.present? ) )  || date_end_partner_changed? || cause_id_changed? || ambassador_changed?
      history_params = { member: self.member,
                         subscription: self.subscription,
                         date_stop_subscription: self.date_stop_subscription,
                         amount: self.amount,
                         code_partner: self.code_partner,
                         date_end_partner: self.date_end_partner,
                         cause_id: self.cause_id,
                         ambassador: self.ambassador }
      self.user_histories.new.create_history(history_params)
    end
  end

  def create_partner_for_third_use_code_partner
    if self.code_partner.present?
      @partner = Partner.find_by_code_partner(self.code_partner)
      if @partner.shared && UserHistory.where(code_partner: self.code_partner).select(:user_id).distinct.count == 2
        @user = User.find(@partner.user_id)
        new_code_partner = "3CP" + @user.id.to_s
        Partner.new.create_code_partner_user(@user, new_code_partner, true, false)
        create_event_intercom(@user, new_code_partner)
      end
    end
  end

  def create_event_intercom(user, code_partner)
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    begin
      intercom.events.create(
        event_name: "third-use-code-partner",
        created_at: Time.now.to_i,
        user_id: user.id,
        email: user.email,
        metadata: {
          code_partner: code_partner
        }
      )
    rescue Intercom::IntercomError => e
      puts e
    end
  end

  def assign_supervisor
    self.supervisor = Business.supervisor_not_admin.near([self.latitude, self.longitude], 10).first
  end

  def save_onesignal_id
    # begin
    #   device_token = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdab" + self.id.to_s
    #   params = {
    #     app_id: ENV['ONESIGNAL_APP_ID'],
    #     device_type: 5,
    #     language: 'fr',
    #     identifier: device_token,
    #     tags: {
    #       user_id: self.id
    #     }
    #   }
    #   response = OneSignal::Player.create(params: params)
    #   self.onesignal_id = JSON.parse(response.body)["id"]
    #   self.save
    #   puts "One Signal Id : " + JSON.parse(response.body)["id"]

    # rescue OneSignal::OneSignalError => e
    #   puts "--- OneSignalError  :"
    #   puts "-- message : #{e.message}"
    #   puts "-- status : #{e.http_status}"
    #   puts "-- body : #{e.http_body}"
    # end
  end

end
