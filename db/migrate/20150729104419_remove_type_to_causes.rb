class RemoveTypeToCauses < ActiveRecord::Migration
  def change
    remove_column :causes, :type, :string
  end
end
