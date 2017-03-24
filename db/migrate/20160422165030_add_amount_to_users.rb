class AddAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :amount, :integer
  end
end
