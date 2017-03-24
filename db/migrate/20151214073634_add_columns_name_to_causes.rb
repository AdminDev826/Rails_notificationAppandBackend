class AddColumnsNameToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :legal_first_name, :string
    add_column :causes, :legal_last_name, :string
  end
end
