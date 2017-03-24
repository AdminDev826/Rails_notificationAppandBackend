class ChangeDefaultTimesToPerks < ActiveRecord::Migration
  def change
    change_column :perks, :times, :integer, :default => 0
  end
end
