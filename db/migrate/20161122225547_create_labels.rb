class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.references :label_category, index: true, foreign_key: true
      t.references :business, index: true, foreign_key: true
      t.references :cause, index: true, foreign_key: true

      t.timestamps
    end
  end
end
