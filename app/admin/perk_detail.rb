ActiveAdmin.register PerkDetail do
  index do
    selectable_column
    column :id
    column :name
    column :description
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :description
    end
    f.actions
  end

permit_params :name, :description
end
