ActiveAdmin.register Business do
  index do
    selectable_column
    column :id
    column :name
    column :business_category
    column :email
    column :city
    column :online
    column :active
    column :created_at
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :business_category
      f.input :email
      f.input :url
      f.input :description
      f.input :street
      f.input :zipcode
      f.input :city
      f.input :facebook
      f.input :twitter
      f.input :instagram
      f.input :latitude
      f.input :longitude
      f.input :telephone
      f.input :picture, :as => :file
      f.input :leader_first_name
      f.input :leader_last_name
      f.input :leader_description
      f.input :leader_phone
      f.input :leader_email
      f.input :leader_picture, :as => :file
      f.input :logo, :as => :file
      f.input :link_video
      f.input :like
      f.input :unlike
    end
    f.inputs "Admin" do
      f.input :active
      f.input :shop
      f.input :online
      f.input :itinerant
      f.input :supervisor
      f.input :supervisor_id
      f.input :admin
    end
    f.actions
  end

  permit_params :name, :business_category_id, :email, :password, :url, :description, :street, :zipcode, :city, :facebook, :twitter, :instagram, :telephone, :picture, :latitude, :longitude, :active, :leader_picture, :leader_first_name, :leader_last_name, :leader_description, :leader_phone, :leader_email, :logo, :shop, :online, :itinerant, :like, :unlike, :link_video, :supervisor, :supervisor_id, :admin
end
