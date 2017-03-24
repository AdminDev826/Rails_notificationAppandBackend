class RemoveColumnsFromBusinesses < ActiveRecord::Migration
  def change
    remove_column :businesses, :user_picture_file_name
    remove_column :businesses, :user_picture_content_type
    remove_column :businesses, :user_picture_file_size
    remove_column :businesses, :user_picture_updated_at
  end
end
