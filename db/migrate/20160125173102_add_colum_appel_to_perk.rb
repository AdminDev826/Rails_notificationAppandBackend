class AddColumAppelToPerk < ActiveRecord::Migration
  def change
    change_column :perks, :nb_views, :integer, :default => 0
    add_column :perks, :appel, :boolean, :default => false, :null => false
    add_column :perks, :durable, :boolean, :default => false, :null => false
  end
end
