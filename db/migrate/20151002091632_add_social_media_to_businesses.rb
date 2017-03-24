class AddSocialMediaToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :facebook, :string
    add_column :businesses, :twitter, :string
    add_column :businesses, :instagram, :string
  end
end
