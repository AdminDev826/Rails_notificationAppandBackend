ActiveAdmin.register BusinessCategory do
  index do
    selectable_column
    column :id
    column :name
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :picture, :as => :file
      f.input :color
      f.input :marker_symbol
    end
    f.actions
  end

permit_params :name, :picture, :color, :marker_symbol
end
