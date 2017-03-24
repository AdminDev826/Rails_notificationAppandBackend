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

require 'test_helper'

class BeneficiaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
