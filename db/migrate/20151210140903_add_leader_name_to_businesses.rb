class AddLeaderNameToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :leader_first_name, :string
    add_column :businesses, :leader_last_name, :string
    add_column :businesses, :leader_description, :string
  end
end
