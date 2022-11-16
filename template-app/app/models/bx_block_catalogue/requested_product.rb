module BxBlockCatalogue
  class RequestedProduct < BxBlockCatalogue::ApplicationRecord
    self.table_name = :requested_products
    belongs_to :account, class_name: "AccountBlock::Account"

    enum status: [:pending, :rejected, :approved]
    has_many_attached :product_image
    has_many_attached :barcode_image
  end
end
