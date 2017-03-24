class AddSupervisorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :supervisor_id, :integer
  end
end
