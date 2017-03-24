class AddColumnAdminToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :admin, :boolean, default: false, null: false
  end
end
