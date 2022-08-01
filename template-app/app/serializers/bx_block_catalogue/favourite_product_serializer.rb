module BxBlockCatalogue
  class FavouriteProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :account_id, :product_id, :favourite, :created_at, :updated_at

    attribute :product do |object|
      object.product
    end

    attribute :account do |object|
      object.account
    end
  end
end