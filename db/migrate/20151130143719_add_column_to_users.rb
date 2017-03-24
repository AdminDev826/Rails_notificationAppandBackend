class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :timestamp
    add_column :users, :nationality, :string
    add_column :users, :country_of_residence, :string
  end
end
