module BxBlockCatalogue
  class OrderSerializer < BuilderBase::BaseSerializer
    attributes :id, :order_name

    attributes :order_id do |obj|
      BxBlockCatalogue::OrderItemSerializer.new(obj.order_items)
    end

  end
end