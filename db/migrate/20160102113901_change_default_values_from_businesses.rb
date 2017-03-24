class ChangeDefaultValuesFromBusinesses < ActiveRecord::Migration
  def change
    change_column :businesses, :active, :boolean, :default => false, :null => false
    change_column :businesses, :online, :boolean, :default => false, :null => false
  end
end
