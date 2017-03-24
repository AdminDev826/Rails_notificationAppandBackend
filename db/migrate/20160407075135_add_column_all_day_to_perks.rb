class AddColumnAllDayToPerks < ActiveRecord::Migration
  def change
    add_column :perks, :all_day, :boolean, :default => false, :null => false
  end
end
