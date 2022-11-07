# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::Product, as: 'product' do
  permit_params :id, :product_name, :product_type, :product_point, :product_rating, :weight, :brand_name,
                :price_post_discount, :price_mrp, :category_id, :positive_good, :negative_not_good, :image, :bar_code, :data_check, :description, :ingredient_list, :food_drink_filter, :filter_category_id, :filter_sub_category_id, ingredient_attributes: [:id, :product_id, :energy, :saturate, :total_sugar, :sodium, :ratio_fatty_acid_lipids, :fibre, :fruit_veg,
                :protein, :vit_a, :vit_c, :vit_d, :vit_b6, :vit_b12, :vit_b9, :vit_b2, :vit_b3, :vit_b1, :vit_b5, :vit_b7, :calcium,
                :iron, :magnesium, :zinc, :iodine, :potassium, :phosphorus, :manganese, :copper, :selenium, :chloride, :chromium,
                :total_fat, :monosaturated_fat, :polyunsaturated_fat, :trans_fat, :soyabean, :cholestrol, :fat, :mono_unsaturated_fat,
                :veg_and_nonveg, :gluteen_free, :added_sugar, :artificial_preservative, :organic, :vegan_product, :egg, :fish,
                :shellfish, :tree_nuts, :peanuts, :wheat, :carbohydrate]

  active_admin_import
  config.batch_actions = true

  before_action :set_product # , only: [:show, :edit, :update, :destroy]

  action_item :only => :index do
    link_to "Calculate Ratings", calculate_ratings_admin_products_path(:calculation_type => "calculate_ratings")
  end

  action_item :only => :index do
    link_to "Calculate NP", calculate_ratings_admin_products_path(:calculation_type => "calculate_np")
  end

  collection_action :calculate_ratings do
    BxBlockCatalogue::ProductCalculationWorker.perform_at(Time.now, params[:calculation_type])
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


      f.inputs "Ingredient", for: [:ingredient, f.object.ingredient || BxBlockCatalogue::Ingredient.new] do |ff|
      
        ff.input :energy
        ff.input :saturate
        ff.input :total_sugar
        ff.input :ratio_fatty_acid_lipids
        ff.input :fruit_veg
        ff.input :protein
        ff.input :vit_a
        ff.input :vit_c
        ff.input :vit_d
        ff.input :vit_b6
        ff.input :vit_b12
        ff.input :vit_b9
        ff.input :vit_b2
        ff.input :vit_b3
        ff.input :vit_b1
        ff.input :vit_b5
        ff.input :vit_b7
        ff.input :calcium
        ff.input :iron
        ff.input :magnesium
        ff.input :zinc
        ff.input :iodine
        ff.input :potassium
        ff.input :phosphorus
        ff.input :manganese
        ff.input :copper
        ff.input :selenium
        ff.input :chloride
        ff.input :chromium
        ff.input :fibre
        ff.input :sodium
        ff.input :total_fat
        ff.input :monosaturated_fat
        ff.input :polyunsaturated_fat
        ff.input :trans_fat
        ff.input :soyabean
        ff.input :cholestrol
        ff.input :fat
        ff.input :mono_unsaturated_fat
        ff.input :veg_and_nonveg
        ff.input :gluteen_free
        ff.input :added_sugar
        ff.input :artificial_preservative
        ff.input :organic
        ff.input :vegan_product
        ff.input :egg
        ff.input :fish
        ff.input :shellfish
        ff.input :tree_nuts
        ff.input :peanuts
        ff.input :wheat
        ff.input :carbohydrate
      end
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
    column :ingredients do |obj|
      obj.ingredient
    end
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
      row :ingredients do |obj|
        obj.ingredient
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
      file = open(file_path) rescue nil
      pcsv = BxBlockCatalogue::ProductCsv.create
      pcsv.csv_file.attach(
        io: file,
        filename: "#{file_path.split("/").last}",
        content_type: params[:active_admin_import_model][:file].content_type
      ) if file
      BxBlockCatalogue::BulkProductImportWorker.perform_at(Time.now, "#{pcsv.id}")
      redirect_to collection_path flash[:notice] = 'Data import processing'
    end
  end
end
