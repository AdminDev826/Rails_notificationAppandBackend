class AddPictureToLabelCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :label_categories, :picture, :string
  end
end
