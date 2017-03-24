class ChangeDefaultValueToPerk < ActiveRecord::Migration
  def change
    change_column :perks, :active, :boolean, :default => false, :null => false
    change_column :perks, :permanent, :boolean, :default => true, :null => false
  end
end
