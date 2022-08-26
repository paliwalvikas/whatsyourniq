module BxBlockCatalogue
  class OrdersController < ApplicationController
    require 'json'
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :current_user, only: %i[create index show]
    before_action :set_order, only: [:create]

    def index
      order_items = current_user.orders.includes(:order_items)
      if order_items.present?
        serializer = BxBlockCatalogue::OrderSerializer.new(order_items, params: {user: current_user }) 
        render json: serializer
      else 
        render json: {error: "no bucket present please create one"}
      end     
    end 

    def create
      order_item = @order.order_items.find_or_initialize_by(order_item_params) 
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

    def destroy
      order = BxBlockCatalogue::Order.find_by_id(params[:order_id])
      if order.present?
        order.destroy
        render json: {message: "Order successfully deleted"}
      else
        render json: {error: "Order not found"}
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
        current_user.orders.find_by_id(order_item_params[:order_id])
      else
        current_user.orders.find_or_create_by(order_params)
      end
      render json: {error: "Order not present"} unless @order.present?
    end
  end
end