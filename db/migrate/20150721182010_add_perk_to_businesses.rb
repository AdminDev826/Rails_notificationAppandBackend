class AddPerkToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :perk, :string
  end
end
