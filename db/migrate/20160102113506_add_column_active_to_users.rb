class AddColumnActiveToUsers < ActiveRecord::Migration
  def change
     add_column :users, :active, :boolean, :default => false, :null => false
     change_column :users, :member, :boolean, :default => false, :null => false
  end
end
