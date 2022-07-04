require 'json'

module BxBlockCatalogue
  class OrdersController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :current_user, only: %i[create]
    before_action :set_order, only: [:create]

    def create  
      order_item = @order.order_items.new(order_item_params) 
      if order_item.save 
        render json: BxBlockCatalogue::OrderSerializer.new(@order)
      else 
        render json: { error: order_item.errors }
      end     
    end

    private

    def order_params
      params.require(:data).permit(:order_name, :order_id).merge({account_id: current_user.id})
    end

    def order_item_params
      params.require(:data).permit(:product_id)
    end  

    def set_order
      @order = BxBlockCatalogue::Order.find_by_id(order_params[:order_id])
      @order ||= BxBlockCatalogue::Order.create(order_params)
      unless @order.id.present?
        return render json: {message: "order not found "}, status: :unprocessable_entity
      end  
    end
  end
end