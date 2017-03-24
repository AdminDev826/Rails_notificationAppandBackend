class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.string :name
      t.string :type
      t.string :description
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :url
      t.string :email
      t.string :telephone

      t.timestamps null: false
    end
  end
end
