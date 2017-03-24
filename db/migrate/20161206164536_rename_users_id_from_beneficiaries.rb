class RenameUsersIdFromBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    rename_column :beneficiaries, :users_id, :user_id
  end
end
