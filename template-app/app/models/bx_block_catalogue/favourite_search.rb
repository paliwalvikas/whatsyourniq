module BxBlockCatalogue
  class FavouriteSearch < BxBlockCatalogue::ApplicationRecord
    self.table_name = :favourite_searches
    belongs_to :category,
                class_name: 'BxBlockCategories::Category',
              	foreign_key: 'category_id'
    belongs_to :account, class_name: 'AccountBlock::Account'
    validates :category_id, presence: true
    serialize :product_category
    serialize :product_sub_category
    serialize :functional_preference
  end
end
