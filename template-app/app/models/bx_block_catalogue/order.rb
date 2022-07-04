module BxBlockCatalogue
  class Order < BxBlockCatalogue::ApplicationRecord
    self.table_name = :orders
    belongs_to :account, class_name: 'AccountBlock::Account'
    has_many :order_items, class_name: 'BxBlockCatalogue::OrderItem', dependent: :destroy 

  end
end