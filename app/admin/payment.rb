ActiveAdmin.register Payment do
  index do
    selectable_column
    column :id
    column :user_id
    column :cause_id
    column :amount_id
    column :done
    column :created_at
    actions
  end
  form do |f|
    f.inputs "Identity" do
      f.input :user_id
      f.input :cause_id
      f.input :amount
    end
    f.inputs "Admin" do
      f.input :done
    end
    f.actions
  end

permit_params :user_id, :cause_id, :amount, :done
end
