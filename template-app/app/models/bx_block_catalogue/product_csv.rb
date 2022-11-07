module BxBlockCatalogue
  class ProductCsv < BxBlockCatalogue::ApplicationRecord
    self.table_name = :product_csvs

    has_one_attached :csv_file
  end
end
