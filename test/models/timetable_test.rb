# == Schema Information
#
# Table name: timetables
#
#  id         :integer          not null, primary key
#  address_id :integer
#  day        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  start_at   :datetime
#  end_at     :datetime
#
# Indexes
#
#  index_timetables_on_address_id  (address_id)
#
# Foreign Keys
#
#  fk_rails_2a3c38b2e1  (address_id => addresses.id)
#

require 'test_helper'

class TimetableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
