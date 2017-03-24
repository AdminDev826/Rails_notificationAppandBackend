class RenameColsFromCauses < ActiveRecord::Migration
  def change
    rename_column :causes, :representative__first_name, :representative_first_name
    rename_column :causes, :representative__last_name, :representative_last_name
  end
end
