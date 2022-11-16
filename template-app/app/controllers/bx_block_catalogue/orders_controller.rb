# frozen_string_literal: true

module BxBlockCatalogue
  class OrdersController < ApplicationController
    require 'json'
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, :current_user, only: %i[create index show update]
    before_action :set_order, only: [:create]
    before_action :get_product, only: %i[show destroy remove_product]

    def index
      order_items = current_user.orders.includes(:order_items)
      if order_items.present?
        serializer = BxBlockCatalogue::OrderSerializer.new(order_items, params: { user: current_user })
        render json: serializer
      else
        render json: { error: 'no bucket present please create one' }
      end
    end

    def create
      order_item = @order.order_items.find_by(order_item_params)
      return render json: { error: 'Food Already Present' } if order_item.present?

      if @order.order_items.create(order_item_params)
        render json: BxBlockCatalogue::OrderSerializer.new(@order)
      else
        render json: { error: order_item.errors }
      end
    end

    def show
      data = []
      order = @order
      if order.present?
        order_calculation = order.order_product_calculation
        data << order_calculation
        serializer = BxBlockCatalogue::OrderSerializer.new(order, params: { user: current_user })
        render json: { nutrition_value: data, product: serializer }
      else
        render json: { error: 'Order not present' }
      end
    end

    def destroy
      @order.destroy
      render json: { message: 'Order successfully deleted' }
    end

    def remove_product
      order_item = @order.order_items.find_by(product_id: params[:product_id])
      if order_item.present?
        order_item.destroy
        render json: { message: 'Product successfully removed', success: 1 }
      else
        render json: { message: 'Product Not Found' , success: 0}
      end
    end

    def update
      order = BxBlockCatalogue::Order.find_by_id(params[:id])
      if order.present?
        order.update(order_params)
        render json: BxBlockCatalogue::OrderSerializer.new(order)
      else
        render json: { message: 'Food Bucket Not Found' }
      end
    end

    private

    def order_params
      params.require(:data).permit(:order_name).merge({ account_id: current_user.id })
    end

    def order_item_params
      params.require(:data).permit(:product_id, :order_id)
    end

    def set_order
      @order = if order_item_params[:order_id].present?
                 current_user.orders.find_by_id(order_item_params[:order_id])
               else
                 order = current_user.orders.find_by(order_params)
                 return render json: { error: 'Basket Name Already Present' } if order.present?

                 current_user.orders.create(order_params)
               end
      render json: { error: 'Basket Not Present' } unless @order.present?
    end

    def get_product
      @order = BxBlockCatalogue::Order.find_by_id(params[:order_id])
      if @order.present?
        @order
      else
        render json: { error: 'Food Basket not found', success: 0 }
      end
    end
  end
end
