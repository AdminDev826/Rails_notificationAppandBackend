ActiveAdmin.register Perk do

  index do
    selectable_column
    column :id
    column :name
    column :business
    column :created_at
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :business
      f.input :description
      f.input :perk_detail
      f.input :times
      f.input :start_date
      f.input :end_date
      f.input :all_day
      f.input :perk_code
      f.input :picture
    end
    f.inputs "Admin" do
      f.input :active
      f.input :appel
      f.input :durable
      f.input :flash
    end
    f.inputs "Notification" do
      f.input :text_notification
      f.input :send_notification
    end
    f.actions
  end

  permit_params :name, :business_id, :description, :perk_detail_id, :times , :start_date, :end_date, :all_day, :perk_code, :active, :appel, :durable, :flash, :picture, :text_notification, :send_notification
end
