class AddColumnMonthToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :nb_month, :integer, default: 1
  end
end
