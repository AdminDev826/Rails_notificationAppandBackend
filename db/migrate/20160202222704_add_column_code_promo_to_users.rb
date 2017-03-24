class AddColumnCodePromoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :code_promo, :string
  end
end
