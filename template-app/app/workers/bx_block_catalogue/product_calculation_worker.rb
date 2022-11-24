module BxBlockCatalogue
  class ProductCalculationWorker  
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options retry: false

    def perform(calculation_type)
      product_import_status = BxBlockCatalogue::ImportStatus.create(job_id: "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}", calculation_status: "Pending")
      product_import_status.status = ""
      csv_headers = ["Pruduct ID", "Product Name", "Calculation Type", "Calculation Status"]
      csv_row = []  
      csv_row << csv_headers
    
      BxBlockCatalogue::Product.find_in_batches do |products|
        products.each do |product|
          if calculation_type == "calculate_np"
            # if !product.np_calculated?  
              status = CalculateRda.new.negative_and_positive(product) if product.bar_code.present?
              csv_row << ["#{product.id}", "#{product.product_name}", "#{calculation_type}", "Success"] if status
              product_import_status.file_status = CSV.generate do |csv|
                csv_row.each do |r_data|
                  csv << r_data
                end
                csv
              # end
            end

          elsif calculation_type == "calculate_ratings"
            # if !product.calculated?  
              status = CalculateProductRating.new.calculation(product) if product.bar_code.present?
              csv_row << ["#{product.id}", "#{product.product_name}", "#{calculation_type}", "Success"] if status
              product_import_status.file_status = CSV.generate do |csv|
                csv_row.each do |r_data|
                  csv << r_data
                end
                csv
              # end
            end

          end
        end
        product_import_status.save
      end

      
      product_import_status.calculation_status = "Success"
      product_import_status.save
      
    end
  end
end