class AddSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscription, :string
    add_column :users, :trial_done, :boolean
    add_column :users, :date_subscription, :date
    add_column :users, :date_last_payment, :date
  end
end
