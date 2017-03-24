class RemoveCategoryToBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :category, :string
  end
end
