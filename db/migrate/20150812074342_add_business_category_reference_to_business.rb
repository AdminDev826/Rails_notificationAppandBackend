class AddBusinessCategoryReferenceToBusiness < ActiveRecord::Migration
  def change
    add_reference :businesses, :business_category, index: true
  end
end