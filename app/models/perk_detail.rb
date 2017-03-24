# == Schema Information
#
# Table name: perk_details
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PerkDetail < ApplicationRecord
  has_many :perks
end
