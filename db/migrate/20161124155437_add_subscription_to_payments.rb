class AddSubscriptionToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :subscription, :string
  end
end
