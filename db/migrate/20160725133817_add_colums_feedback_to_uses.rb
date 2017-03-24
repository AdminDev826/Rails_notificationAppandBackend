class AddColumsFeedbackToUses < ActiveRecord::Migration
  def change
    add_column :uses, :feedback, :boolean, default: false
    add_column :uses, :like, :boolean, default: false
    add_column :uses, :unlike, :boolean, default: false
  end
end
