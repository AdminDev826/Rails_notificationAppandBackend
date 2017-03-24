class AddColumnMangopayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mangopay_id, :string
  end
end
