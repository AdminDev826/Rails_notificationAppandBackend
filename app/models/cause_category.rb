# == Schema Information
#
# Table name: cause_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color      :string
#  picture    :string
#

class CauseCategory < ApplicationRecord
  has_many :causes

  validates_size_of :picture, maximum: 1.megabytes,
    message: "Cette image dépasse 1 MG !", if: :picture_changed?
  mount_uploader :picture, IconUploader

end
