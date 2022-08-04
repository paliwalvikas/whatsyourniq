module BxBlockCatalogue
  class FavouriteSearchSerializer < BuilderBase::BaseSerializer
    attributes :id, :food_type, :product_category, :product_sub_category, :niq_score, :food_allergies, :food_preference, :functional_preference, :health_preference, :account_id, :product_count, :added_count, :created_at, :updated_at

    attribute :product_category do |object|
      eval(object.product_category)
    end

    attribute :product_sub_category do |object|
      eval(object.product_sub_category)
    end
    
    attribute :functional_preference do |object|
      eval(object.functional_preference)
    end
  end
end
