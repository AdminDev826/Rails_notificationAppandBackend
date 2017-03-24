class RemoveColumnPartnerIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :partner_id
  end
end
