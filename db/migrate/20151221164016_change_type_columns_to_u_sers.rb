class ChangeTypeColumnsToUSers < ActiveRecord::Migration
  def change
    change_column :users, :trial_done, :boolean, :default => false, :null => false
    change_column :users, :date_subscription, :datetime
    change_column :users, :date_last_payment , :datetime
  end
end
