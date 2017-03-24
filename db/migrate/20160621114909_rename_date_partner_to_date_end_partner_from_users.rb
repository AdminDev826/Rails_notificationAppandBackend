class RenameDatePartnerToDateEndPartnerFromUsers < ActiveRecord::Migration
  def change
    rename_column :users, :date_partner, :date_end_partner
  end
end
