class CreateUses < ActiveRecord::Migration
  def change
    create_table :uses do |t|
      t.references :user, index: true, foreign_key: true
      t.references :perk, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
