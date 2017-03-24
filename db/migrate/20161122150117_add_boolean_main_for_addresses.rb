class AddBooleanMainForAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :name, :string
    add_column :addresses, :main, :boolean, default: false, null: false
  end
end
