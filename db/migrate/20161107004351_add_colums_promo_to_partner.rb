class AddColumsPromoToPartner < ActiveRecord::Migration[5.0]
  def change
      remove_column :partners, :date_end_promo, :date
      add_column :partners, :date_start_promo, :date
      add_column :partners, :date_end_promo, :date
      add_reference :partners, :user, index: true
      add_column :partners, :only_for, :boolean, default: false, null: false
      add_column :partners, :except_for, :boolean, default: false, null: false
  end
end
