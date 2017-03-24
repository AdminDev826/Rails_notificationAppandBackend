class AddColumnsForMigrationCloudinary < ActiveRecord::Migration
  def change
    add_column :users, :picture, :string
    add_column :businesses, :picture, :string
    add_column :businesses, :leader_picture, :string
    add_column :businesses, :logo, :string
    add_column :business_categories, :picture, :string
    add_column :causes, :picture, :string
    add_column :causes, :logo, :string
    add_column :cause_categories, :picture, :string
    add_column :perks, :picture, :string
  end
end
