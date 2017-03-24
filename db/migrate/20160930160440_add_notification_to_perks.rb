class AddNotificationToPerks < ActiveRecord::Migration
  def change
    add_column :perks, :text_notification, :string
    add_column :perks, :send_notification, :boolean, default: false
  end
end
