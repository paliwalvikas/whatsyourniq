require 'csv'

module BxBlockCatalogue
  class BulkProductImportWorker 
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options retry: 3#, lock: :until_executed, on_conflict: { client: :log, server: :raise }

    # ERROR_CLASSES = [ActiveModel::UnknownAttributeError].freeze
    
    def perform(product_csv_id)
      begin
        # ActiveStorage::Current.host = "http://localhost:3000"
        pcsv = BxBlockCatalogue::ProductCsv.find_by_id(product_csv_id)
        csv_text = open(pcsv.csv_file) do |io|
          io.set_encoding('utf-8')
          io.read
        end
        
        row_count = 0
        product_import_status = BxBlockCatalogue::ImportStatus.create!(job_id: "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}")

        report_data = []
        success_data = []
        failer_data = []
        csv_headers = ["Row Number", "Product Name", "Error Message", "Status"]

        csv = CSV.parse(csv_text, headers: true)

        product_import_status.record_file_contain = csv&.count
        count = 0
        csv.each.each do |product_data|
          row_count += 1
          product_data = product_data.to_h.reject { |k, _v| k.blank? }
          product_data = product_data.transform_keys { |k| k&.gsub(/\P{ASCII}/, '') }
          product_params = product_data.except('id', 'product_id', 'energy', 'saturate', 'total_sugar', 'sodium','ratio_fatty_acid_lipids', 'fruit_veg', 'fibre', 'protein', 'vit_a','vit_c','vit_d','vit_b6','vit_b12','vit_b9','vit_b2','vit_b3','vit_b1','vit_b5','vit_b7','calcium','iron','magnesium','zinc','iodine','potassium','phosphorus','manganese','copper','selenium','chloride','chromium','carbohydrate', 'total_fat', 'monosaturated_fat', 'polyunsaturated_fat', 'fatty_acid', 'mono_unsaturated_fat', 'veg_and_nonveg', 'gluteen_free', 'added_sugar', 'artificial_preservative', 'organic', 'vegan_product', 'egg', 'fish', 'shellfish', 'tree_nuts', 'peanuts', 'wheat', 'soyabean','cholestrol', 'trans_fat', 'nutritional', 'fat')

          ingredient_params = product_data.except('id', 'product_name', 'product_type','weight','price_mrp','price_post_discount','brand_name','category_id','image','bar_code','data_check','description','ingredient_list','food_drink_filter','category_filter','category_type_filter', 'website', 'nutritional', 'fat', 'user_email')

          filter_category = BxBlockCategories::FilterCategory.find_or_create_by(name: product_params["category_filter"])
          filter_sub_category = BxBlockCategories::FilterSubCategory.find_or_create_by(name: product_params['category_type_filter'], filter_category_id: filter_category.id)

          if product_params["product_type"] == "Oil" || product_params["product_type"] == "Cheese"
            product_params["product_type"] = "cheese_and_oil"
          end

          product = BxBlockCatalogue::Product.find_or_initialize_by(bar_code: product_params['bar_code'])

          product.attributes = product_params.except('bar_code', 'filter_category', 'category_id', 'category_type_filter','image', 'user_email')
          product.category_id = BxBlockCategories::Category.new.find_category_type(product_params['category_id'])
          product.filter_category_id = filter_category.id
          product.filter_sub_category_id = filter_sub_category.id
          ingredient = product.ingredient ||= product.build_ingredient
          product.calculated = false
          product.np_calculated = false
          if product_params["user_email"].present?
            product.account_id = find_account(product_params["user_email"])
          end
          if product.save
            CalculateProductRating.new.calculation(product)
            CalculateRda.new.negative_and_positive(product)
            img = product_params["image"]&.split("\n")&.first
            file_url = URI.parse(img) rescue nil
            if file_url
              file = open(img) rescue nil
              product.image.attach(
                io: file,
                filename: "#{product&.product_name&.split&.first}.#{file.content_type_parse.first.split("/").last}",
                content_type: file.content_type_parse.first
              ) if file
            end

            ingredient.update(ingredient_params)

            success_data << ["#{row_count}", "#{product.product_name}", "", "Success"]
            product_import_status.record_uploaded = success_data.count  
          end

          if product.errors.any?
            failer_data << ["#{row_count}", "#{product.product_name}", "#{product.errors.messages.map {|key, value| key.to_s + " " + value.first.to_s}.join(",")}", "Failed"]
            product_import_status.record_failed = failer_data.count
          end

          report_data = (success_data + failer_data).unshift(csv_headers)

          product_import_status.file_status = CSV.generate do |csv|
            report_data.each do |r_data|
              csv << r_data
            end
            csv
          end

          product_import_status.save
        end

        product_import_status.status = "Failed" unless failer_data.empty?
        product_import_status.status = "Success" if failer_data.empty?
        product_import_status.status = "Success" if failer_data.empty?
        product_import_status.save

      rescue Exception => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")
      end
    end

    def find_account(user_email)
      AccountBlock::Account.find_by_email(user_email)&.id
    end
  end
end