class AddDateSubscriptionCauseForUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_support, :date
  end
end
