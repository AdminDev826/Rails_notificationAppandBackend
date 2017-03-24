class AddKindOfferToPerks < ActiveRecord::Migration[5.0]
  def change
    add_column :perks, :offer, :boolean, default: false, null: false
    add_column :perks, :value, :boolean, default: false, null: false
    add_column :perks, :percent, :boolean, default: false, null: false
    add_column :perks, :amount, :integer
  end
end
