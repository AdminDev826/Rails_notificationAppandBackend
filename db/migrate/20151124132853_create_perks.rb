class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.string :perk
      t.references :business, index: true, foreign_key: true
      t.text :description
      t.string :detail
      t.integer :times
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :permanent
      t.boolean :flash
      t.boolean :active
      t.string :perk_code

      t.timestamps null: false
    end
  end
end
