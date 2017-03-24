class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :business, index: true, foreign_key: true
      t.string :day
      t.string :street
      t.string :zipcode
      t.string :city
      t.float :latitude
      t.float :longitude
      t.boolean  :active, default: true, null: false
      t.timestamps null: false
    end
  end
end
