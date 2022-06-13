ActiveAdmin.register AccountBlock::Account, as: "Users" do
  permit_params :full_name, :email, :full_phone_number, :activated 

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :email
      f.input :full_phone_number
      f.input :activated
    end
    f.actions
  end

  index title: 'users' do
  	id_column
    column :full_name
    column :email
    column :full_phone_number
    column :activated
    actions
  end   

  show do
    attributes_table do
      row :full_name
      row :email
      row :full_phone_number
      row :activated
    end  
  end

end