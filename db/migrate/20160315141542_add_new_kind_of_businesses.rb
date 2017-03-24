class AddNewKindOfBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :shop, :boolean, :default => true, :null => false
    add_column :businesses, :itinerant, :boolean, :default => false, :null => false
  end
end
