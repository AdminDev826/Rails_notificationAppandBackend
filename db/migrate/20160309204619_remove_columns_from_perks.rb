class RemoveColumnsFromPerks < ActiveRecord::Migration
  def change
    remove_column :perks, :detail
  end
end
