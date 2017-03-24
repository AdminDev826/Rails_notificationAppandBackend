ActiveAdmin.register Cause do
  index do
    selectable_column
    column :id
    column :name
    column :cause_category
    column :impact
    column :email
    column :telephone
    column :created_at
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :cause_category
      f.input :email
      f.input :url
      f.input :description
      f.input :street
      f.input :impact
      f.input :amount_impact
      f.input :description_impact
      f.input :zipcode
      f.input :city
      f.input :representative_first_name
      f.input :representative_last_name
      f.input :telephone
      f.input :facebook
      f.input :twitter
      f.input :instagram
      f.input :latitude
      f.input :longitude
      f.input :picture, :as => :file
      f.input :logo, :as => :file
      f.input :link_video
      f.input :like
      f.input :unlike
    end
    f.inputs "Admin" do
      f.input :active
    end
    f.actions
  end

  permit_params :name, :email, :cause_category_id, :impact, :url, :latitude, :longitude, :description, :amount_impact, :description_impact, :street, :zipcode, :city, :telephone, :facebook, :twitter, :instagram, :picture, :logo, :active, :representative_first_name,
 :representative_last_name, :link_video, :like, :unlike

end
