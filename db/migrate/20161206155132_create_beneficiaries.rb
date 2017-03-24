class CreateBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    create_table :beneficiaries do |t|
      t.references :users, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :used, default: false, null: false

      t.timestamps
    end
  end
end
