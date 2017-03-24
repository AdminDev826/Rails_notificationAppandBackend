class AddColumnDoneToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :done, :boolean, :default => false, :null => false
  end
end
