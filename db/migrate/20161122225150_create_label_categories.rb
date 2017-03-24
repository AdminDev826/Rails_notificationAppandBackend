class CreateLabelCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :label_categories do |t|
      t.string :name
      t.string :model

      t.timestamps
    end
  end
end
