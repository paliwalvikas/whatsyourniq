# frozen_string_literal: true
require 'csv'

module BxBlockCatalogue
  class ProductWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def product_data_import(file)
      csv_text = open(file) do |io|
        io.set_encoding('utf-8')
        io.read
      end
      
      row_count = 0
      product_import_status = BxBlockCatalogue::ProductImportStatus.create(job_id: "Job: #{Time.now}")
      error_file = "error_file.csv"
      writer = []
      writer << ["Row Number", "Product Name", "Status"]

      csv = CSV.parse(csv_text, headers: true)
      csv.each.each do |product_data|
        row_count += 1
        product_data = product_data.to_h.reject { |k, _v| k.blank? }
        product_data = product_data.transform_keys { |k| k&.gsub(/\P{ASCII}/, '') }
      
        product_params = product_data.except('id', 'product_id', 'energy', 'saturate', 'total_sugar', 'sodium','ratio_fatty_acid_lipids', 'fruit_veg', 'fibre', 'protein', 'vit_a','vit_c','vit_d','vit_b6','vit_b12','vit_b9','vit_b2','vit_b3','vit_b1','vit_b5','vit_b7','calcium','iron','magnesium','zinc','iodine','potassium','phosphorus','manganese','copper','selenium','chloride','chromium','carbohydrate', 'total_fat', 'monosaturated_fat', 'polyunsaturated_fat', 'fatty_acid', 'mono_unsaturated_fat', 'veg_and_nonveg', 'gluteen_free', 'added_sugar', 'artificial_preservative', 'organic', 'vegan_product', 'egg', 'fish', 'shellfish', 'tree_nuts', 'peanuts', 'wheat', 'soyabean','cholestrol', 'trans_fat')

        ingredient_params = product_data.except('id', 'product_name', 'product_type','weight','price_mrp','price_post_discount','brand_name','category_id','image','bar_code','data_check','description','ingredient_list','food_drink_filter','category_filter','category_type_filter')

        next if BxBlockCatalogue::Product.find_by(bar_code: product_params['bar_code'])
        filter_category = BxBlockCategories::FilterCategory.find_or_create_by(name: product_params["category_filter"])
        filter_sub_category = BxBlockCategories::FilterSubCategory.find_or_create_by(name: product_params['category_type_filter'], filter_category_id: filter_category.id)

        product = BxBlockCatalogue::Product.new(product_params)
        product.category_id = BxBlockCategories::Category.new.find_category_type(product_params['category_id'])
      
        product.filter_category_id = filter_category.id
        product.filter_sub_category_id = filter_sub_category.id
        product.image_url = product_params["image"]
        ingredient = product.build_ingredient(ingredient_params)

        if product.save
            writer << ["#{row_count}", "#{product.product_name}", "Success"]
        else
            writer << ["#{row_count}", "#{product.product_name}", "Failed"]
        end
        ingredient.save
      end

      CSV.open(error_file, 'w') do |csv|
        writer.each do |writ|
          csv << writ
        end
      end

      # table = CSV.parse(File.read("error_file.csv"), headers: true)

      # csv_file = File.open(csv_data)
      # blob = ActiveStorage::Blob.create_after_upload!(
      #   io: CSV.parse(File.read("error_file.csv"), headers: true),
      #   filename: "my_file.csv",
      #   content_type: "text/csv"
      # )
      # my_csv = CSV.open("tmp/my_file.csv", "wb") do |csv|
      #   writer.each do |writ|
      #     csv << writ
      #   end
      # end
      
      product_import_status.status = "Success"
      # product_import_status.save

      # byebug
      # product_import_status.error_file.attach(blob)
      product_import_status.file_status = File.read("error_file.csv")
      product_import_status.save
    end
  end
end