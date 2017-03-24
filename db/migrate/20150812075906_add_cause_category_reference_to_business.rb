class AddCauseCategoryReferenceToBusiness < ActiveRecord::Migration
  def change
    add_reference :causes, :cause_category, index: true
  end
end
