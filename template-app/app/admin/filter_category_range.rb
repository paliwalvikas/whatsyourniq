ActiveAdmin.register BxBlockCategories::FilterCategoryRange, as: "filter_categorie_range" do
  permit_params :rang_for_a, :rang_for_b, :rang_for_c, :filter_category_id

  form do |f|
    f.inputs do
      f.input :filter_category_id, as: :select, collection: resource.filter_category_data.pluck(:name, :id)
      f.input :rang_for_a
      f.input :rang_for_b
      f.input :rang_for_c
    end
    f.actions
  end

  index title: 'categories' do
    id_column
    column :filter_category
    column :rang_for_a
    column :rang_for_b
    column :rang_for_c
    actions
  end   

  show do
    attributes_table do
      row :filter_category
      row :rang_for_a
      row :rang_for_b
      row :rang_for_c
    end  
  end
  
end
