class RemoveColumnFlashFromPerks < ActiveRecord::Migration
  def change
    remove_column :perks, :flash
  end
end
