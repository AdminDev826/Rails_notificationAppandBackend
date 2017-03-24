class AddColumsToBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    add_column :beneficiaries, :code_partner, :string
    add_column :beneficiaries, :paid, :boolean, default: false, null: false
  end
end
