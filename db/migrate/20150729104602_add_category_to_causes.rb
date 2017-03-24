class AddCategoryToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :category, :string
  end
end
