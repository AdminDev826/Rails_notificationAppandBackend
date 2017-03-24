class AddColumnNbViewsToPerks < ActiveRecord::Migration
  def change
    add_column :perks, :nb_views, :integer
  end
end
