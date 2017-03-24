class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.string :email
      t.string :code_partner

      t.timestamps null: false
    end
  end
end
