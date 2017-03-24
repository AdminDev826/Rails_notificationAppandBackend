class AddMarkerNameToBusinessCategories < ActiveRecord::Migration
  def change
    add_column :business_categories, :marker_symbol, :string
  end
end
