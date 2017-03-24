ActiveAdmin.register Partner do
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :code_partner
    column :nb_month
    column :times
    column :promo
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :email
      f.input :code_partner
      f.input :nb_month
      f.input :times
      f.input :promo
      f.input :date_start_promo
      f.input :date_end_promo
      f.input :user_id
      f.input :exclusive
      f.input :shared
    end
    f.actions
  end

permit_params :name, :email, :code_partner, :nb_month, :times, :promo, :date_start_promo, :date_end_promo, :user_id, :exclusive, :shared
end
