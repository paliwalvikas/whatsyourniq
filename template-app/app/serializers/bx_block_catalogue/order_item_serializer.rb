module BxBlockCatalogue
  class OrderItemSerializer < BuilderBase::BaseSerializer
    attributes :id

    attributes :product_id do |obj|
      BxBlockCatalogue::ProductSerializer.new(obj.product)
    end

  end
end