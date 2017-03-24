class ChangeDelaultTrialDoneToUsers < ActiveRecord::Migration
  def change
    change_column_default(:users, :trial_done, false)
  end
end
