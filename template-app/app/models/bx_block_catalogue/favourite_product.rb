module BxBlockCatalogue
  class FavouriteProduct < BxBlockCatalogue::ApplicationRecord
    self.table_name = :favourite_products

    belongs_to :account,
                class_name: 'AccountBlock::Account',
                foreign_key: 'account_id'
    belongs_to :product,
                class_name: 'BxBlockCatalogue::Product',
                foreign_key: 'product_id'

    validates :product_id, uniqueness: {scope: [:account_id]}

  end
end
