class AddColumnsPhoneToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :leader_phone, :string
    add_column :businesses, :leader_email, :string
  end
end