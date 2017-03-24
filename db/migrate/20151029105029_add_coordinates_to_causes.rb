class AddCoordinatesToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :latitude, :float
    add_column :causes, :longitude, :float
  end
end
