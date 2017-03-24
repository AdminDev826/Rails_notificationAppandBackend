class RenameColumOnlyExceptFromPartners < ActiveRecord::Migration[5.0]
  def change
    rename_column :partners, :only_for, :exclusive
    rename_column :partners, :except_for, :shared
  end
end
