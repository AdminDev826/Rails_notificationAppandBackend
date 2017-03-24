class AddColumnAmbassadorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ambassador, :boolean, default: false
  end
end
