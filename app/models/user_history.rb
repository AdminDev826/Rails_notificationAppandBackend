# == Schema Information
#
# Table name: user_histories
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  member                 :boolean          default(FALSE), not null
#  subscription           :string
#  date_stop_subscription :datetime
#  amount                 :integer
#  code_partner           :string
#  date_end_partner       :date
#  cause_id               :integer
#  ambassador             :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_user_histories_on_cause_id  (cause_id)
#  index_user_histories_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_8a39241862  (cause_id => causes.id)
#  fk_rails_c69ac0e32d  (user_id => users.id)
#

class UserHistory < ApplicationRecord
  belongs_to :user
  belongs_to :cause

  def create_history(history_params)
    self.member = history_params[:member]
    self.subscription = history_params[:subscription]
    self.date_stop_subscription = history_params[:date_stop_subscription]
    self.amount = history_params[:amount]
    self.code_partner = history_params[:code_partner]
    self.date_end_partner = history_params[:date_end_partner]
    self.cause_id = history_params[:cause_id]
    self.ambassador = history_params[:ambassador]
    self.save
  end
end
