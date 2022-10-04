module BxBlockCatalogue
  class FavouriteSearchSerializer < BuilderBase::BaseSerializer
    attributes :id, :product_category, :product_sub_category, :niq_score, :food_allergies, :food_preference, :functional_preference, :health_preference, :account_id, :product_count, :favourite, :added_count, :created_at, :updated_at

  end
end
