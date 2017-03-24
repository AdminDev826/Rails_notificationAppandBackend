class AddColorToCategories < ActiveRecord::Migration
  def change
    add_column :business_categories, :color, :string
    add_column :cause_categories, :color, :string
  end
end
