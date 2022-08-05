module BxBlockCatalogue
  class OrderSerializer < BuilderBase::BaseSerializer
    attributes :id, :order_name

    attributes :product_count do |obj|
      obj.order_items.count
    end

    attributes :order_id do |obj|
      BxBlockCatalogue::OrderItemSerializer.new(obj.order_items)
    end

  end
end