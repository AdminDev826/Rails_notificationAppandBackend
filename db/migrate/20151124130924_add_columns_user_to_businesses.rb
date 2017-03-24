class AddColumnsUserToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :user_picture_file_name, :string
    add_column :businesses, :user_picture_content_type, :string
    add_column :businesses, :user_picture_file_size, :string
    add_column :businesses, :user_picture_updated_at, :datetime
  end
end
