class AddMangopayToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :mangopay_id, :string
    add_column :causes, :wallet_id, :string
  end
end
