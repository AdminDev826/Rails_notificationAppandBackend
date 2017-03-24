class AddColumnsChoiceGiftToBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    add_column :beneficiaries, :nb_month, :integer
    add_column :beneficiaries, :amount, :integer
  end
end
