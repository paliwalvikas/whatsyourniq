ActiveAdmin.register BxBlockCategories::Category, as: "category" do
  permit_params :name, :category_type

  form do |f|
    f.inputs do
      f.input :category_type
      f.input :created_at
      f.input :updated_at
    end
    f.actions
  end

  index title: 'users' do
    id_column
    column :category_type
    column :created_at
    column :updated_at
    actions
  end   

  show do
    attributes_table do
      row :category_type
      row :created_at
      row :updated_at
    end  
  end
end
