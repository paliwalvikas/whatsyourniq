module BxBlockCatalogue
  class ProductCalculationWorker  
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options lock: :until_executed, on_conflict: { client: :log, server: :raise }
    # sidekiq_options retry: false

    def perform(calculation_type)
      product_import_status = BxBlockCatalogue::ImportStatus.create(job_id: "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}", calculation_status: "Pending")
      csv_headers = ["Pruduct ID", "Product Name", "Calculation Type", "Calculation Status"]
      csv_row = []  
      csv_row << csv_headers

      products = BxBlockCatalogue::Product.all.order(:id)
    
      products.each do |product|
        if calculation_type == "calculate_np"
          # if !product.np_calculated?  
            status = product.negative_and_positive if product.bar_code.present?
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
            status = product.calculation if product.bar_code.present?
            csv_row << ["#{product.id}", "#{product.product_name}", "#{calculation_type}", "Success"] if status
            product_import_status.file_status = CSV.generate do |csv|
              csv_row.each do |r_data|
                csv << r_data
              end
              csv
            # end
          end

        end
        product_import_status.save
      end

      
      product_import_status.calculation_status = "Success"
      product_import_status.save
      
    end
  end
end