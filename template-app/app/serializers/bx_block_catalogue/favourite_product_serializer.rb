module BxBlockCatalogue
  class FavouriteProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :account_id, :product_id, :favourite, :created_at, :updated_at

    attributes :added_to_compare do |object|
      p_id = object&.product&.id
      data = object&.account&.compare_products&.find_by(product_id: p_id)
      data.present?
    end

    attribute :product do |object, _params|
      BxBlockCatalogue::ProductSerializer.new(object&.product)
    end

    attribute :account do |object|
      object.account
    end
  end
end