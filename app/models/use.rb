# == Schema Information
#
# Table name: uses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  perk_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feedback   :boolean          default(FALSE)
#  like       :boolean          default(FALSE)
#  unlike     :boolean          default(FALSE)
#  unused     :boolean          default(FALSE)
#
# Indexes
#
#  index_uses_on_perk_id  (perk_id)
#  index_uses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_7057e30f7a  (perk_id => perks.id)
#  fk_rails_b60db94a9d  (user_id => users.id)
#

class Use < ApplicationRecord
  belongs_to :user
  belongs_to :perk

  after_create :create_code_partner_for_first_use_perk

  scope :without_feedback, -> { where(feedback: false) }
  scope :used, -> { where('feedback = ? or (feedback = ? and unused = ?)', false, true, false) }
  scope :liked, -> { where(like: true) }

  private

  def create_code_partner_for_first_use_perk
    @user = User.find(user_id)
    if @user.uses.count == 1
      code_partner = "1BP" + user.id.to_s
      Partner.new.create_code_partner_user(user, code_partner, false, true)
      create_event_intercom("first-use-perk", @user, code_partner)
    else
      create_event_intercom("use-perk", @user, "")
    end
  end

  def create_event_intercom(event_name, user, code_partner)
    @perk = Perk.find(perk_id)
    intercom = Intercom::Client.new(app_id: ENV['INTERCOM_API_ID'], api_key: ENV['INTERCOM_API_KEY'])
    begin
      intercom.events.create(
        event_name: event_name,
        created_at: Time.now.to_i,
        user_id: user.id,
        email: user.email,
        metadata: {
          business_name: @perk.business.name,
          perk_name: @perk.name,
          code_partner: code_partner
        }
      )
    rescue Intercom::IntercomError => e
      puts e
    end
  end
end
