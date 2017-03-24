class AddActiveColumnToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :active, :boolean, :default => false, :null => false
  end
end
