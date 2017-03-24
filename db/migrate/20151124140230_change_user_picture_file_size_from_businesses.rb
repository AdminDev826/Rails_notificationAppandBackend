class ChangeUserPictureFileSizeFromBusinesses < ActiveRecord::Migration
  def self.up
    change_column :businesses, :user_picture_file_size, :string
  end

  def self.down
    change_column :businesses, :user_picture_file_size, :integer
  end
end
