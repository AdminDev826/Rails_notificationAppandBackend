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

require 'test_helper'

class UserHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
