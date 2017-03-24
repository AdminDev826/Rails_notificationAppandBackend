class CreatePerkDetails < ActiveRecord::Migration
  def change
    create_table :perk_details do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
