class DropObsoletModels < ActiveRecord::Migration[5.0]
  def change
    drop_table :prospects, if_exists: true
    drop_table :business_hours, if_exists: true
  end
end
