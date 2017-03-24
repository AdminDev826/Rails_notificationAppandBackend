class AddDateStopSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_stop_subscription, :datetime
  end
end
