class ChangeDefaultValueActiveFromPerks < ActiveRecord::Migration
  def change
    change_column :perks, :active, :boolean, :default => true, :null => false
  end
end
