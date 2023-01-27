# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::RequestedProduct, as: 'Requested_product' do
  permit_params :name, :status, :weight, :category_id
  config.filters = false

  index title: 'Requested_product' do
    selectable_column
    id_column
    column :name
    column :account
    column :weight
    column :refernce_url
    column :status
    column :category
    column 'product_image' do |obj|
      obj.product_image.each.map do |img|
        image_tag(url_for(img), class: 'short_image', onclick: 'generateModel(this);')
      end
    end
    column 'barcode_image' do |obj|
      obj.barcode_image.each.map do |img|
        image_tag(url_for(img), class: 'short_image', onclick: 'generateModel(this);')
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :account
      row :weight
      row :refernce_url
      row :status
      row :category
      row 'product_image' do |ad|
        ad.product_image.each.map do |image, _index|
          image_tag(url_for(image), class: 'short_image', onclick: 'generateModel(this);')
        end
      end
      row 'barcode_image' do |ad|
        ad.barcode_image.each.map do |image, _index|
          image_tag(url_for(image), class: 'short_image', onclick: 'generateModel(this);')
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :weight
      f.input :status
      f.input :name
      f.input :category, as: :select, collection: BxBlockCategories::Category.pluck(:category_type, :id)
    end
    f.actions
  end
end
