class AddDetailToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :detail, :string
  end
end
