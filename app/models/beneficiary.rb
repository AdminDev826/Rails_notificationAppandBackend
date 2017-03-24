# == Schema Information
#
# Table name: beneficiaries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  first_name :string
#  last_name  :string
#  email      :string
#  used       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  paid       :boolean          default(FALSE), not null
#  nb_month   :integer
#  amount     :integer
#
# Indexes
#
#  index_beneficiaries_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_2d8fc173f1  (user_id => users.id)
#

class Beneficiary < ApplicationRecord
  belongs_to :users, class_name: 'User', foreign_key: 'user_id'

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :used, -> { where(used: true) }

  after_create :send_event_intercom_slack

  private

  def send_event_intercom_slack

    user = self.users

    # SEND EVENT TO INTERCOM
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    begin
      intercom.events.create(
        event_name: "subscribe_gift",
        created_at: Time.now.to_i,
        user_id: user.id,
        email: user.email,
        metadata: {
          first_name: self.first_name,
          last_name: self.last_name,
          email: self.email,
          nb_month: self.nb_month,
          url: "https://app.cforgood.com/signup_beneficiary/?#{self.id}"
        }
      )
    rescue Intercom::IntercomError => e
      puts e
    end

    # SEND EVENT TO SLACK
    message =  user.find_name_or_email? + " a offert *" + self.nb_month.to_s + "* mois gratuit(s) à " + self.first_name + ' ' + self.last_name
    send_message_to_slack(ENV['SLACK_WEBHOOK_USER_URL'], message)

  end
end
