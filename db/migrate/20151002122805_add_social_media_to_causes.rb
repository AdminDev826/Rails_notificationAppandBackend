class AddSocialMediaToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :facebook, :string
    add_column :causes, :twitter, :string
    add_column :causes, :instagram, :string
  end
end
