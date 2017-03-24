class ChangeDefaultValueActiveFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :active, :boolean, default: true
  end
end
