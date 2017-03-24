class RemoveColumPermanentFromPerk < ActiveRecord::Migration
  def change
    remove_column :perks, :permanent
  end
end
