class RemoveWalletIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :wallet_id
  end
end
