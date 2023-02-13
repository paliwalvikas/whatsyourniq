module BxBlockCatalogue
  class LogedFood < BxBlockCatalogue::ApplicationRecord
    self.table_name = :loged_foods

    belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'account_id'
    belongs_to :product, class_name: 'BxBlockCatalogue::Product', foreign_key: 'product_id'

    enum food_type: [:breakfast, :lunch, :dinner, :snacks]
  end
end
