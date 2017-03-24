class AddColumsPromoDateToPartners < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :promo, :boolean, default: false
    add_column :partners, :date_end_promo, :date
  end
end
