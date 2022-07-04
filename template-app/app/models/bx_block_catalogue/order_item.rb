module BxBlockCatalogue
  class OrderItem < BxBlockCatalogue::ApplicationRecord
    self.table_name = :order_items
    belongs_to :order, class_name: 'BxBlockCatalogue::Order'
    belongs_to :product, class_name: 'BxBlockCatalogue::Product'
  end
end