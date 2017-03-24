class AddColumnsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :active, :boolean
    add_column :businesses, :online, :boolean
  end
end
