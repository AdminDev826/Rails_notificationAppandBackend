class CreateUserHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_histories do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :member, default: false, null: false
      t.string :subscription
      t.datetime :date_stop_subscription
      t.integer :amount
      t.string :code_partner
      t.date :date_end_partner
      t.references :cause, index: true, foreign_key: true
      t.boolean :ambassador, default: false, null: false

      t.timestamps
    end
  end
end
