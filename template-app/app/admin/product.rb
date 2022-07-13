# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::Product, as: 'product' do
  permit_params :id, :product_name, :product_type, :product_point, :product_rating, :weight, :brand_name, :price_post_discount, :price_mrp, :category_id ,:positive_good, :negative_not_good, :image, :bar_code, :data_check, :description,:ingredient_list,:food_drink_filter,:category_filter,:category_type_filter

  active_admin_import
  before_action :set_product#, only: [:show, :edit, :update, :destroy]



  form  do |f|
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
      f.input :category_filter
      f.input :category_type_filter
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
    column :positive_good do |obj|
      obj.positive_good
    end
    column :negative_not_good
    column :image do |obj|
      link_to obj.image&.service_url&.split('?')&.first if obj.image.present?
    end
    column :bar_code
    column :data_check
    column :weight
    column :price_mrp
    column :description
    column :ingredient_list
    column :food_drink_filter
    column :category_filter
    column :category_type_filter
    column :price_post_discount
    column :category_id do |obj|
      obj&.category&.category_type
    end  
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
      row :image 
      row :image do |obj|
        link_to obj.image&.service_url&.split('?')&.first if obj.image.attached?
      end
      row :bar_code
      row :data_check
      row :positive_good do |obj|
        obj.positive_good
      end
      row :negative_not_good
      row :price_mrp
      row :price_post_discount
      row :category_id do |obj|
        obj&.category&.category_type
    end  
    end
  end


  controller do

    def set_product
      ActiveStorage::Current.host = request.base_url
    end

    def do_import
      csv_text = open(params[:active_admin_import_model][:file]) do |io|
        io.set_encoding('utf-8')
        io.read
      end
      count = 0
      products = []
      csv = CSV.parse(csv_text, headers: true)
      csv.reverse_each.each do |product_data|
        product_data = product_data.to_h.reject { |k, _v| k.blank? }
        product_data = product_data.transform_keys { |k| k&.gsub(/\P{ASCII}/, '') }
        product_params = product_data.except('id', 'product_id', 'energy', 'saturate', 'total_sugar', 'sodium','ratio_fatty_acid_lipids', 'fruit_veg', 'fibre', 'protein', 'vit_a','vit_c','vit_d','vit_b6','vit_b12','vit_b9','vit_b2','vit_b3','vit_b1','vit_b5','vit_b7','calcium','iron','magnesium','zinc','iodine','potassium','phosphorus','manganese','copper','selenium','chloride','chromium','carbohydrate', 'total_fat', 'monosaturated_fat', 'polyunsaturated_fat', 'fatty_acid', 'mono_unsaturated_fat', 'veg_and_nonveg', 'gluteen_free', 'added_sugar', 'artificial_preservative', 'organic', 'vegan_product', 'egg', 'fish', 'shellfish', 'tree_nuts', 'peanuts', 'wheat', 'soyabean','cholestrol', 'trans_fat')
        
        ingredient_params = product_data.except('id', 'product_name', 'product_type','weight','price_mrp','price_post_discount','brand_name','category_id','image','bar_code','data_check','description','ingredient_list','food_drink_filter','category_filter','category_type_filter')
  
        # begin
          product = BxBlockCatalogue::Product.new(product_params)
          product.image_url = product_params["image"]
          ingredient = product.build_ingredient(ingredient_params) 
          product.save!
          count += 1
        # rescue StandardError => e
        #   e.message
        # end
      end
      # BxBlockCatalogue::Product.import(products, recursive: true)
      redirect_to collection_path flash[:notice] =
                                    I18n.t('active_admin_import.imported', count: count, model: 'product',
                                                                           plural_model: 'products')
      end
    
  end 
end
