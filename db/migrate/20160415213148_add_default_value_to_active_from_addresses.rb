class AddDefaultValueToActiveFromAddresses < ActiveRecord::Migration
  def change
    change_column :addresses, :active, :boolean, :default => true, :null => false
  end
end
