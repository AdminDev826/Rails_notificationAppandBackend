class CreateTimetables < ActiveRecord::Migration[5.0]
  def change
    create_table :timetables do |t|
      t.references :address, index: true, foreign_key: true
      t.string :day
      t.datetime :am_start_at
      t.datetime :am_end_at
      t.datetime :pm_start_at
      t.datetime :pm_end_at

      t.timestamps
    end
  end
end
