class AddCoordinatesToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :latitude, :float
    add_column :businesses, :longitude, :float
  end
end
