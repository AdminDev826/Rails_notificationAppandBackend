# == Schema Information
#
# Table name: causes
#
#  id                        :integer          not null, primary key
#  name                      :string
#  description               :text
#  street                    :string
#  zipcode                   :string
#  city                      :string
#  url                       :string
#  email                     :string
#  telephone                 :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  impact                    :string
#  cause_category_id         :integer
#  facebook                  :string
#  twitter                   :string
#  instagram                 :string
#  description_impact        :string
#  latitude                  :float
#  longitude                 :float
#  mangopay_id               :string
#  wallet_id                 :string
#  representative_first_name :string
#  representative_last_name  :string
#  amount_impact             :integer
#  active                    :boolean          default(FALSE), not null
#  link_video                :string
#  picture                   :string
#  logo                      :string
#  like                      :integer          default(0)
#  unlike                    :integer          default(0)
#
# Indexes
#
#  index_causes_on_cause_category_id  (cause_category_id)
#

class Cause < ApplicationRecord
  belongs_to :cause_category
  has_many :users
  has_many :payments
  has_many :user_histories

  validates_size_of :picture, maximum: 2.megabytes,
    message: "Cette image dépasse 2 MG !", if: :picture_changed?
  mount_uploader :picture, PictureUploader

  validates_size_of :logo, maximum: 1.megabytes,
    message: "Cette image dépasse 1 MG !", if: :logo_changed?
  mount_uploader :logo, IconUploader


  validates :name, presence: true
  validates :email, presence: true
  validates :url, format: { with: /\Ahttps?:\/\/[\S]+/, message: "Votre URL doit commencer par http:// ou https://" }, allow_blank: true

  # validates :representative_first_name, presence: true
  # validates :representative_last_name, presence: true

  after_create :subscribe_to_newsletter_cause
  after_save :create_mangopay_data!
  after_save :update_data_intercom

  private

  def create_mangopay_data!
    if !self.mangopay_id.present?
      # CREATE LEGAL USER
      @mangopay_user = MangopayServices.new(self).create_mangopay_legal_user
      self.update_attributes(mangopay_id: @mangopay_user["Id"])
      #CREATE WALLET
      if self.mangopay_id.present?
        @mangopay_wallet = MangopayServices.new(self).create_mangopay_wallet
        self.update_attributes(wallet_id: @mangopay_wallet["Id"])
      end
    end
  end

  def subscribe_to_newsletter_cause
    if Rails.env.production?
      SubscribeToNewsletterCause.new(self).run
    end
  end

  def update_data_intercom
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    begin
      user = intercom.users.create(
        :user_id => 'C'+id.to_s,
        :email => email,
        :name => name,
        :created_at => created_at
      )
      user.custom_attributes["user_type"]   = "cause"
      user.custom_attributes["user_active"] = active
      user.custom_attributes["first_name"]  = representative_first_name
      intercom.users.save(user)
    rescue Intercom::IntercomError => e
      puts e
    end
  end
end

