class RemoveAmPmFromTimetables < ActiveRecord::Migration[5.0]
  def change
    remove_column :timetables, :am_start_at
    remove_column :timetables, :am_end_at
    remove_column :timetables, :pm_start_at
    remove_column :timetables, :pm_end_at
    add_column :timetables, :start_at, :datetime
    add_column :timetables, :end_at, :datetime
  end
end
