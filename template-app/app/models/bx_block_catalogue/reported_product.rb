module BxBlockCatalogue
  class ReportedProduct < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reported_products
    has_many :reported_product_answers, class_name: 'BxBlockFaqAndContactUs::ReportedProductAnswer'
    belongs_to :account, class_name: "AccountBlock::Account", foreign_key: 'account_id'
    belongs_to :product, class_name: "BxBlockCatalogue::Product", foreign_key: 'product_id'
    enum status: [:pending, :updated]
  end
end
