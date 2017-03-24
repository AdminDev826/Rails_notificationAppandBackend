class RenamePromoToPartnerToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :code_promo, :code_partner
  end
end
