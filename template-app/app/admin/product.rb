ActiveAdmin.register BxBlockCatalogue::Product do
  permit_params :id, :product_name, :product_type

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :product_type
      
    end
    f.actions

  end

  index  title: 'product' do
    id_column
    column :product_name
    column :product_type
    column :product_point
    column :product_rating
    actions
  end

  show do
    attributes_table do
      row :product_name
      row :product_type
      row :product_point
      row :product_rating
    end
  end
end