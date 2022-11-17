module BxBlockCatalogue
  class CompareProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :selected, :account_id, :product_id, :created_at, :updated_at
  
    attribute :added_to_fav do |object|
      compare = object&.account&.favourite_products&.where(product_id: object&.product_id)
      compare.present? 
    end
  end
end
