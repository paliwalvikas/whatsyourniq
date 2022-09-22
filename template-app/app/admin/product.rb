# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::Product, as: 'product' do
  permit_params :id, :product_name, :product_type, :product_point, :product_rating, :weight, :brand_name,
                :price_post_discount, :price_mrp, :category_id, :positive_good, :negative_not_good, :image, :bar_code, :data_check, :description, :ingredient_list, :food_drink_filter, :filter_category_id, :filter_sub_category_id

  active_admin_import
  config.batch_actions = true

  before_action :set_product # , only: [:show, :edit, :update, :destroy]

  batch_action :product_calculation do |selection|
    BxBlockCatalogue::ProductCalculation.perform_later
    redirect_to collection_path flash[:notice] = 'Calculation on product is processing.'
  end

  action_item only: :index do
    link_to('Download Sample CSV', download_admin_products_path)
  end

  action_item :product_import_status, only: :index do
    link_to 'Import Status', '/admin/import_statuses'
  end
  
  collection_action :download, method: :get do
    file_name = "#{Rails.root}/lib/product_importable_file_format.csv"
    send_file file_name, type: 'application/csv'
  end

  scope :green
  scope :red
  scope :n_a
  scope :n_c

  filter :product_name
  filter :product_type, as: :select, collection: BxBlockCatalogue::Product.product_types
  filter :brand_name
  filter :weight
  filter :price_mrp
  filter :price_post_discount
  filter :product_point
  filter :product_rating
  filter :category_id, as: :select, collection: BxBlockCategories::Category.all.pluck(:category_type, :id)
  filter :bar_code
  filter :data_check
  filter :ingredient_list
  filter :food_drink_filter, as: :select, collection: BxBlockCatalogue::Product.food_drink_filters
  filter :filter_category_id, as: :select, collection: BxBlockCategories::FilterCategory.pluck(:name, :id)
  filter :filter_sub_category_id, as: :select, collection: BxBlockCategories::FilterSubCategory.all.pluck(:name, :id)

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
      f.input :category_id, as: :select, collection: BxBlockCategories::Category.all.pluck(:category_type, :id)
      f.input :positive_good
      f.input :image, as: :file
      f.input :bar_code
      f.input :data_check
      f.input :negative_not_good
      f.input :description
      f.input :ingredient_list
      f.input :food_drink_filter
      f.input :filter_category_id, as: :select, collection: BxBlockCategories::FilterCategory.pluck(:name, :id)
      f.input :filter_sub_category_id, as: :select,
                                       collection: BxBlockCategories::FilterSubCategory.all.pluck(:name, :id)
    end
    f.actions
  end

  index title: 'product' do
    selectable_column
    id_column
    column :product_name
    column :product_type
    column :filter_category_id do |obj|
      obj.filter_category.name
    end
    column :filter_sub_category_id do |obj|
      obj.filter_sub_category.name
    end
    column :category_id do |obj|
      obj&.category&.category_type
    end
    column :brand_name
    column :bar_code
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
      row :product_point do |obj|
        obj.product_point.present? ? obj.product_point : "NA"
      end
      row :product_rating do |obj|
        obj.product_rating.present? ? obj.product_rating : "NA"
      end
      row :brand_name
      row :weight
      row :image
      row :image do |obj|
        link_to image_tag(obj.image&.service_url&.split('?')&.first, size: "150x200"), obj.image&.service_url&.split('?')&.first if obj.image.attached?
      end
      row :bar_code
      row :data_check
      row :positive_good, &:positive_good
      row :negative_not_good
      row :price_mrp
      row :description
      row :ingredient_list
      row :price_post_discount
      row :category_id do |obj|
        obj&.category&.category_type
      end
      row :filter_category_id do |obj|
        obj.filter_category.name
      end
      row :filter_sub_category_id do |obj|
        obj.filter_sub_category.name
      end
    end
  end

  controller do
    def set_product
      ActiveStorage::Current.host = request.base_url
    end

    def do_import
      redirect_to import_admin_products_path, flash: {error: "Please select file!"} and return if params[:active_admin_import_model].nil?
      redirect_to import_admin_products_path, flash: {error: "File format not valid!"} and return unless params[:active_admin_import_model][:file].content_type.include?("csv")
      file_path = params[:active_admin_import_model][:file].path
      BxBlockCatalogue::BulkProductImport.perform_later(file_path)
      redirect_to collection_path flash[:notice] = 'Data import processing'
    end
  end
end
