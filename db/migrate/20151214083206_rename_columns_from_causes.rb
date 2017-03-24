class RenameColumnsFromCauses < ActiveRecord::Migration
  def change
    rename_column :causes, :legal_first_name, :representative__first_name
    rename_column :causes, :legal_last_name, :representative__last_name
  end
end
