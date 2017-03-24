class ChangeTimeToDateTimeFromAddresses < ActiveRecord::Migration
  def up
    remove_column :addresses, :start_time
    remove_column :addresses, :end_time
  end

  def down
    add_column :addresses, :start_time, :datetime
    add_column :addresses, :end_time, :datetime
  end
end
