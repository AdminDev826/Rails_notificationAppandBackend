class AddDescriptionImpactToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :description_impact, :string
  end
end
