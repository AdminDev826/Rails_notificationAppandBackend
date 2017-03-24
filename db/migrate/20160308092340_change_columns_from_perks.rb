class ChangeColumnsFromPerks < ActiveRecord::Migration
  def change
    rename_column :perks, :perk, :name
    add_reference :perks, :perk_detail, index: true
  end
end
