class AddDescriptionPerk2ToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :description2_perk, :string
  end
end
