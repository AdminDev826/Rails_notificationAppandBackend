class AddUnusedToUses < ActiveRecord::Migration
  def change
    add_column :uses, :unused, :boolean, default: false
  end
end
