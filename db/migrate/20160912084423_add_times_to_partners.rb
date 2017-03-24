class AddTimesToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :times, :integer, :default => 0
  end
end
