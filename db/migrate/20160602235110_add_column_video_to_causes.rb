class AddColumnVideoToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :link_video, :string
  end
end
