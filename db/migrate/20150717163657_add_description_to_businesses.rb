class AddDescriptionToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :description, :string
  end
end
