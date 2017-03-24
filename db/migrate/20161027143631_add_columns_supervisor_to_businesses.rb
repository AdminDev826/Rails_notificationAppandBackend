class AddColumnsSupervisorToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :supervisor, :boolean, default: false
    add_column :businesses, :supervisor_id, :integer
  end
end
