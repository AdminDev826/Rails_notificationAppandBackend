class CreateBusinessCategory < ActiveRecord::Migration
  def change
    create_table :business_categories do |t|
      t.string      :name
      t.timestamps null: false
    end
  end
end
