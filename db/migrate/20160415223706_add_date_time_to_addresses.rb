class AddDateTimeToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :start_time, :datetime
    add_column :addresses, :end_time, :datetime
  end
end
