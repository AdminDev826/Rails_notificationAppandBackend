class CreateCauseCategory < ActiveRecord::Migration
  def change
    create_table :cause_categories do |t|
      t.string      :name
      t.timestamps null: false
    end
  end
end
