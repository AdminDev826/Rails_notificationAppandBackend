# == Schema Information
#
# Table name: labels
#
#  id                :integer          not null, primary key
#  label_category_id :integer
#  business_id       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_labels_on_business_id        (business_id)
#  index_labels_on_label_category_id  (label_category_id)
#
# Foreign Keys
#
#  fk_rails_d1353b377d  (label_category_id => label_categories.id)
#  fk_rails_e4ba0658b6  (business_id => businesses.id)
#

class Label < ApplicationRecord
  belongs_to :label_category
  belongs_to :business
end
