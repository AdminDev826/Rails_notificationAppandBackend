class AddTimeColumnsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :start_time, :time
    add_column :addresses, :end_time, :time
  end
end
