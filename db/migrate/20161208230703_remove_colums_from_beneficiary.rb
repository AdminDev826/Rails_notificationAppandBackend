class RemoveColumsFromBeneficiary < ActiveRecord::Migration[5.0]
  def change
    remove_column :beneficiaries, :code_partner, :string
  end
end
