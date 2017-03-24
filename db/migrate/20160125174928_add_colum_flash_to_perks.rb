class AddColumFlashToPerks < ActiveRecord::Migration
  def change
    add_column :perks, :flash, :boolean, :default => false, :null => false
  end
end
