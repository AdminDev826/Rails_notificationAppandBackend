class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :category
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :url
      t.string :telephone
      t.string :email

      t.timestamps null: false
    end
  end
end
