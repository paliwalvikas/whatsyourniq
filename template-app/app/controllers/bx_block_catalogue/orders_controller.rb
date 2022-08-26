module BxBlockCatalogue
  class OrdersController < ApplicationController
    require 'json'
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :current_user, only: %i[create index show]
    before_action :set_order, only: [:create]

    def index
      orders = BxBlockCatalogue::Order.where(account_id: current_user.id)
      order_items = orders.includes(:order_items)
      if orders.present?
        serializer = BxBlockCatalogue::OrderSerializer.new(order_items, params: {user: current_user }) 
        render json: serializer
      else 
        render json: {error: "no bucket present please create one"}
      end     
    end 

    def create
      order_item = @order.order_items.new(order_item_params) 
      if order_item.save 
        render json: BxBlockCatalogue::OrderSerializer.new(@order)
      else 
        render json: { error: order_item.errors }
      end     
    end

    def show 
      data = []
      order = BxBlockCatalogue::Order.find_by_id(params[:order_id])
      if order.present?
        calculation = order.order_product_calculation
        data << calculation
        serializer = BxBlockCatalogue::OrderSerializer.new(order, params: {user: current_user })
        render json: { nutrition_value: data, product: serializer } 
      else
        render json: {error: "Order not present"}
      end
    end    

    private

    def order_params
      params.require(:data).permit(:order_name).merge({account_id: current_user.id})
    end

    def order_item_params
      params.require(:data).permit(:product_id, :order_id)
    end  

    def set_order
      @order = if order_item_params[:order_id].present?
        BxBlockCatalogue::Order.find_by_id(order_item_params[:order_id])
      else
        BxBlockCatalogue::Order.create(order_params)
      end 
    end
  end
end