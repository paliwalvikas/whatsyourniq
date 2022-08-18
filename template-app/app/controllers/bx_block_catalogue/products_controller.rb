# frozen_string_literal: true

require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token, only: %i[smart_search_filters product_smart_search update index search niq_score show delete_old_data]

    def index
      if product = BxBlockCatalogue::Product.find_by(id: params[:id])
        product.calculation
        data = product.rda_calculation

        render json: ProductSerializer.new(product,
                                           params: { good_ingredient: data[:good_ingredient],
                                                     not_so_good_ingredient: data[:not_so_good_ingredient] })
      else
        render json: { errors: 'Product not found' }
      end
    end

    def update
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.calculation || product.rda_calculation
        render json: { message: 'Calculated successfully!' }
      else
        render json: { error: 'Something went wrong!' }
      end
    end

    def show
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.present?
        render json: ProductSerializer.new(product)
      else
        render json: { errors: 'Product not present' }
      end
    end

    def niq_score
      if (prod = BxBlockCatalogue::Product.find_by(id: params[:product_id])) && (prod.product_type.present? && prod.category_id.present?)
        product = case_for_product(prod.product_rating, prod.product_type, prod.category_id, prod.id)
      end
      if product.present?
        render json: ProductSerializer.new(product)
      else
        render json: { errors: 'Product not found' }
      end
    end

    def prod_health_preference
      Product.all.each do |product|
        product.product_health_preference
      end
    end

    def search
      product = BxBlockCatalogue::Product.where(
        'lower(products.product_name) LIKE ? OR lower(products.bar_code) LIKE ?', "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"
      )
      if product.present?
        product = product.where(category_id: params[:category_id]) if params[:category_id].present?
        serializer = valid_user.present? ? ProductSerializer.new(product, params: {user: valid_user }) : ProductSerializer.new(product)
        render json: serializer
      else
        render json: { errors: 'Product Not Found' }, status: :ok
      end
    end

    def delete_old_data
      Product.delete_all
      Ingredient.delete_all
      render json: { message: 'deleted successfully!' }
    end

    def smart_search_filters
      data = BxBlockCatalogue::SmartFiltersService.new.filters(params)
      render json: data
    end

    def product_smart_search
      fav_s = BxBlockCatalogue::FavouriteSearch.find_by(id: params[:fav_search_id])
      if fav_s.present?
        data = BxBlockCatalogue::SmartSearchService.new.smart_search(fav_s)
        products = data.present? ? data_batches(data) : []
        serializer = valid_user.present? ? ProductSerializer.new(products, params: {user: valid_user }) : ProductSerializer.new(products)
        render json: serializer
      else
        render json: { errors: 'Product not found' }
      end
    end

    def calculation_for_rda
      if product = Product.find_by(id: params[:id])
        render json: { data: product.rda_calculation }
      else
        render json: { errors: 'Product not found' }
      end
    end

    def compare_product
      prd_ids =  current_user.compare_products.where(selected: true)
      if prd_ids.count > 1
        data = cmp_product(prd_ids.pluck(:product_id))
        if data.present? 
          render json: {data: data} 
        else 
          render json: {message: "Product not found"}
        end
      else
        render json: {message: "Please add one more product"}
      end
    end

    private

    def data_batches(product)
      products = []
      product.find_in_batches(batch_size: 7000) do |prod|
        # serializer = valid_user.present? ? ProductSerializer.new(prod, params: {user: valid_user }) : ProductSerializer.new(prod)
        products << prod
      end
      products.flatten
    end

    def case_for_product(rating, type, category_id, id)
      case rating
      when 'A'
        a = find_product(category_id, type, ['A'], id)
      when 'B'
        a = find_product(category_id, type, %w[A B], id)
      when 'C'
        a = find_product(category_id, type, %w[A B C], id)
      when 'D'
        a = find_product(category_id, type, %w[A B C D], id)
      when 'E'
        a = find_product(category_id, type, %w[A B C D E], id)
      end
      a
    end

    def cmp_product(ids)
      products = Product.where(id: ids)
      data = []
      products.each do |product|
        product.calculation
        p_data = product.rda_calculation

        data << ProductSerializer.new(product, params: {good_ingredient: p_data[:good_ingredient], not_so_good_ingredient: p_data[:not_so_good_ingredient]})
      end
      data
    end

    def find_product(category_id, type, rating, p_id)
      product = BxBlockCatalogue::Product.where(product_type: type, product_rating: rating,
                                                category_id: category_id).where.not(id: p_id).order(product_rating: :asc)
      product.first(5)
    end

    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end  

    def product_found
      @product = BxBlockCatalogue::Product.find_by(id: params[:id])
    end
    
  end
end
