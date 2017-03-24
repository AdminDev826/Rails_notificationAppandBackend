class RemoveLinkCauseFromLabel < ActiveRecord::Migration[5.0]
  def change
    remove_column :label_categories, :model
    remove_reference(:labels, :cause, index: true, foreign_key: true)
  end
end
