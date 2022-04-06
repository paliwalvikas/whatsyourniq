# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::Product, as: 'product' do
  permit_params :id, :product_name, :product_type, :product_point, :product_rating, :weight, :brand_name, :price_post_discount, :price_mrp

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :product_type
      f.input :brand_name
      f.input :weight
      f.input :price_mrp
      f.input :price_post_discount
      f.input :product_point
      f.input :product_rating
    end
    f.actions
  end

  index title: 'product' do
    id_column
    column :product_name
    column :product_type
    column :product_point
    column :product_rating
    column :brand_name
    column :weight
    column :price_mrp
    column :price_post_discount
    actions do |resource|
      link_to 'calculate_rating', '#', onclick: "calculateRating(#{resource.id});"
    end
  end

  show do
    attributes_table do
      row :product_name
      row :product_type
      row :product_point
      row :product_rating
      row :brand_name
      row :weight
      row :price_mrp
      row :price_post_discount
    end
  end
end
