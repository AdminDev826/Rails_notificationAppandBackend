class AddColumnDeletedToPerks < ActiveRecord::Migration
  def change
    add_column :perks, :deleted, :boolean, :default => false, :null => false
  end
end
