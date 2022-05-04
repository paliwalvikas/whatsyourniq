# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::Product, as: 'product' do
  permit_params :id, :product_name, :product_type, :product_point, :product_rating, :weight, :brand_name, :price_post_discount, :price_mrp
  active_admin_import

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


  controller do
    def do_import
      csv_text = open(params[:active_admin_import_model][:file]) do |io|
        io.set_encoding('utf-8')
        io.read
      end
      a = 'abc'
      count = 0
      products = []
      csv = CSV.parse(csv_text, headers: true)
      csv.reverse_each.each do |product_data|
        product_data = product_data.to_h.reject { |k, _v| k.blank? }
        product_data = product_data.transform_keys { |k| k&.gsub(/\P{ASCII}/, '') }
        product_params = product_data.except('id', 'product_id', 'energy', 'saturate', 'total_sugar', 'sodium','ratio_fatty_acid_lipids', 'fruit_veg', 'fibre', 'protein', 'vit_a','vit_c','vit_d','vit_b6','vit_b12','vit_b9','vit_b2','vit_b3','vit_b1','vit_b5','vit_b7','calcium','iron','magnesium','zinc','iodine','potassium','phosphorus','manganese','copper','selenium','chloride','chromium')
        
        ingredient_params = product_data.except('id', 'product_name', 'product_type','weight','price_mrp','price_post_discount','brand_name')

        begin
          product = BxBlockCatalogue::Product.new(product_params)
          ingredient = product.build_ingredient(ingredient_params) 
          products << product
          ingredient.energy = a
          count += 1
        rescue StandardError => e
          e.message
        end
      end
      BxBlockCatalogue::Product.import(products, recursive: true)
      redirect_to collection_path flash[:notice] =
                                    I18n.t('active_admin_import.imported', count: count, model: 'product',
                                                                           plural_model: 'products')
      end
    end 
end
