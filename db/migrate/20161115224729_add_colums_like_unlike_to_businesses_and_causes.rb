class AddColumsLikeUnlikeToBusinessesAndCauses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :like, :integer, default: 0
    add_column :businesses, :unlike, :integer, default: 0
    add_column :businesses, :link_video, :string
    add_column :causes, :like, :integer, default: 0
    add_column :causes, :unlike, :integer, default: 0
  end
end
