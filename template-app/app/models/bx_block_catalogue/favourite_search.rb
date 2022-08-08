module BxBlockCatalogue
  class FavouriteSearch < BxBlockCatalogue::ApplicationRecord
    self.table_name = :favourite_searches

    belongs_to :account, class_name: 'AccountBlock::Account'
    serialize :product_category
    serialize :product_sub_category
    serialize :functional_preference
    before_create :inc_added_count
    after_create :update_product_count

    scope :product_category, ->(product_category) { where product_category: product_category }
    scope :product_sub_category, ->(product_sub_category) { where product_sub_category: product_sub_category }
    scope :niq_score, ->(niq_score) { where niq_score: niq_score }
    scope :food_allergies, ->(food_allergies) { where food_allergies: food_allergies }
    scope :food_preference, ->(food_preference) { where food_preference: food_preference }
    scope :favourite, ->(favourite) { where favourite: favourite }
    scope :functional_preference, ->(functional_preference) { where functional_preference: functional_preference }
    
    def inc_added_count
      self.added_count = self.account.favourite_searches.where(favourite: true).count+1
    end

    def update_product_count
      prod = BxBlockCatalogue::SmartSearchService.new.smart_search(self)
      prod.present? ? self.update(product_count: prod.count) : self.update(product_count: 0)
    end

  end
end
