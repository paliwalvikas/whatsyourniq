module BxBlockCatalogue
  class ProductCalculation < BuilderBase::ApplicationJob
    queue_as :low_priority

    def perform

      product_import_status = BxBlockCatalogue::ProductImportStatus.create(job_id: "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}", calculation_status: "Pending")
      csv_headers = ["Pruduct ID", "Product Name", "Calculation Status"]
      csv_row = []

      products = BxBlockCatalogue::Product.all
      if products.present?
        products.each do |product|
          status = product.calculation if product.bar_code.present?
          csv_row << ["#{product.id}", "#{product.product_name}", "Success"] if status
          csv_row << ["#{product.id}", "#{product.product_name}", "Pending"] unless status
        end
      end

      csv_data = csv_row.unshift(csv_headers)
      product_import_status.file_status = CSV.generate do |csv|
        csv_data.each do |r_data|
          csv << r_data
        end
        csv
      end

      product_import_status.calculation_status = "Success"
      product_import_status.save
      
    end
  end
end