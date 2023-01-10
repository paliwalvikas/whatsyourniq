module BxBlockCatalogue
  class FavouriteProductsController < ApplicationController
    before_action :find_fav_prod, only: [:update]
    before_action :find_product, only: [:destroy]
    before_action :filter_for_fav, only: [:filter_fav_product]

    def index
      fav_prod = current_user.favourite_products.all
      if fav_prod.present?
        render json: FavouriteProductSerializer.new(fav_prod), status: :ok
      else
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    def create
      fav_prod = current_user.favourite_products.new(fav_prod_params)
      if fav_prod.save
        render json: FavouriteProductSerializer.new(fav_prod)
                    .serializable_hash,
                    status: :created
      else
        render json: ErrorSerializer.new(fav_prod).serializable_hash,
        status: :unprocessable_entity
      end
    end

    def update
      if @fav_prod.present? && @fav_prod.update(favourite: params[:favourite])
        render json: FavouriteProductSerializer.new(@fav_prod)
                         .serializable_hash,
               status: :ok
      else
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    def fav_search
      query = search_query if params[:query].present?
      prd_id = current_user&.favourite_products&.select(:product_id)
      products = BxBlockCatalogue::Product.where(id: prd_id)&.where(query)
      if products.present? && params[:query].present?
        return render json: FavouriteProductSerializer.new(FavouriteProduct.where(product_id: products&.ids), params: {user: current_user})
      else
        render json: { errors: 'Product Not Found' }, status: :ok
      end
    end

    def destroy
      if @fav_prod.present? && @fav_prod.destroy
        render json: { success: true, message: "Product successfully deleted" }, status: :ok
      else
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    def filter_fav_product
      if @fav.present?
        render json: FavouriteProductSerializer.new(@fav).serializable_hash,
               status: :ok,
               message: "Products successfully found"
      else
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    private

    def filter_for_fav
      p_ids = current_user&.favourite_products.select(:product_id)
      product = BxBlockCatalogue::Product.where(id: p_ids)
      if (params[:min].present? || params[:max].present?) && params[:product_rating].present?
        product = niq_filter(product)
        product = price_filter(product) 
      elsif params[:product_rating].present? 
        product = niq_filter(product)
      elsif params[:min].present? || params[:max].present?
        product = price_filter(product)
      end
      fav_prod = current_user&.favourite_products&.where(product_id: product&.ids)&.joins(:product).order("products.product_rating asc")
      @fav = fav_prod
    end

    def niq_filter(product)
      products = product.where(product_rating: params[:product_rating])
    end

    def price_filter(product)
      ids = []
      p_prd = product.where(price_mrp: nil)&.select(:id, :price_post_discount)
      products = product.where.not(price_mrp: nil).select(:id, :price_mrp)
      if params[:min].present? && params[:max].present?
        ids << products.where(price_mrp: [params[:min].to_i..params[:max].to_i])&.ids
        ids << p_prd.where(price_post_discount: [params[:min].to_i..params[:max].to_i])&.ids
      elsif params[:min].present?
        ids << products.where(price_mrp: params[:min].to_i..).ids
        ids << p_prd.where(price_post_discount: params[:min].to_i..)&.ids
      elsif params[:max].present?
        ids << products.where(price_mrp: 0..params[:max].to_i)&.ids
        ids << p_prd.where(price_post_discount: 0..params[:max].to_i)&.ids
      end
      product.where(id: ids.flatten)
    end

    def search_query
      query = params[:query].split(' ')
      query_string = ""
      query.each do |data|
        query_string += "(product_name ilike '%#{data}%' OR bar_code ilike '%#{data}%')"
        query_string += " AND " unless data == query[-1]
      end
      query_string
    end

    def fav_prod_params
      params.require(:data).require(:attributes).permit(:account_id, :product_id, :favourite)
    end

    def find_product
      @fav_prod = current_user.favourite_products.find_by(product_id: params[:product_id] || params[:id])
    end

    def find_fav_prod
      @fav_prod = current_user.favourite_products.find_by_id(params[:id])
    end
  end
end