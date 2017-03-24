class Add < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :onesignal_id, :string
  end
end
