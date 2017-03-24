class AddPartnerToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :partner, index: true, foreign_key: true
    add_column :users, :date_partner, :date
  end
end
