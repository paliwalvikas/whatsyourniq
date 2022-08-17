module BxBlockCatalogue
  class OrderItemSerializer < BuilderBase::BaseSerializer
    attributes :id

    attributes :product_id do |obj, _params|
      BxBlockCatalogue::ProductSerializer.new(obj.product, params: {user: _params[:user]})
    end

  end
end