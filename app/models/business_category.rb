# == Schema Information
#
# Table name: business_categories
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  color         :string
#  marker_symbol :string
#  picture       :string
#

class BusinessCategory < ApplicationRecord
  has_many :businesses

  validates_size_of :picture, maximum: 1.megabytes,
    message: "Cette image dépasse 1 MG !", if: :picture_changed?
  mount_uploader :picture, IconUploader

end
