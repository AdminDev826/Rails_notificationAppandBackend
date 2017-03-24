class AddWalletIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wallet_id, :string
  end
end
