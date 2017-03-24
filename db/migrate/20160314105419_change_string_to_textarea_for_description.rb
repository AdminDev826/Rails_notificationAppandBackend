class ChangeStringToTextareaForDescription < ActiveRecord::Migration
  def change
    add_column :causes, :amount_impact, :integer
    change_column :causes, :description, :text

    change_column :businesses, :description, :text
    change_column :businesses, :leader_description , :text
  end
end
