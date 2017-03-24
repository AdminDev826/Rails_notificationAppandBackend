# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  cause_id     :integer
#  amount       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  done         :boolean          default(FALSE), not null
#  subscription :string
#
# Indexes
#
#  index_payments_on_cause_id  (cause_id)
#  index_payments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_081dc04a02  (user_id => users.id)
#  fk_rails_de053cb0c6  (cause_id => causes.id)
#

class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :cause

  scope :valid_payment, -> { where(done: true) }

  validates :user_id, presence: true
  validates :cause_id, presence: true
  validates :amount, presence: true
  validates :subscription, presence: true

  after_create :create_event_intercom, :send_payment_slack

  private

  def create_event_intercom
    @user = User.find(user_id)
    if @user.payments.valid_payment.count <= 1 && self.done == true
      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
      begin
        user = intercom.users.find(:user_id => @user.id)
        user.custom_attributes["first_payment"] = Time.now.to_date
        intercom.users.save(user)

        intercom.events.create(
          event_name: "first-payment",
          created_at: Time.now.to_i,
          user_id: @user.id,
          email: @user.email,
          metadata: {
            amount:  @user.amount,
            cause_id: @user.cause.name
          }
        )
      rescue Intercom::IntercomError => e
        puts e
      end
    end
  end

  def send_payment_slack

    if @user.payments.valid_payment.count <= 1 && self.done == true
      message = @user.find_name_or_email? + " a souscrit une participation "
      message += self.subscription == "M" ? "mensuelle" : "annuelle"
      message += " de " + @user.amount.to_s + "€. |" + @user.email + "|"
      send_message_to_slack(ENV['SLACK_WEBHOOK_USER_URL'], message)
    end
  end

end
