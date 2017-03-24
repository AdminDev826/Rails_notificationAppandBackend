class AddDescriptionPerkToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :description_perk, :string
    add_column :businesses, :detail_perk, :string
    remove_column :businesses, :detail, :string
  end
end
