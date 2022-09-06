module BxBlockCatalogue
  class ProductImportStatus < BxBlockCatalogue::ApplicationRecord
    self.table_name = :product_import_statuses

    has_one_attached :error_file
  end
end