class RemoveCategoryToCause < ActiveRecord::Migration
  def change
    remove_column :causes, :category, :string
  end
end
