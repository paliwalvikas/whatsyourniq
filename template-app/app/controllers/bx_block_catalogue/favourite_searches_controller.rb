module BxBlockCatalogue
  class FavouriteSearchesController < ApplicationController
    before_action :find_favourite, only: [:update, :destroy]
    before_action :initilize_fav_search, only: [:create]
    # before_action :update_product_count, only: [:create, :update]
    skip_before_action :validate_json_web_token, only: %i[create]

    def index
      fav_search = current_user.favourite_searches.where(favourite: true).order(added_count: :asc)
      if fav_search.present?
        render json: FavouriteSearchSerializer.new(fav_search)
                 .serializable_hash,
        status: :ok
      else
        render json: {message: "Record not found."}
      end
    end

  	def create
      if @fav_search.save(validates: false)
        render json: FavouriteSearchSerializer.new(@fav_search)
                 .serializable_hash,
        status: :created
      else
        render json: ErrorSerializer.new(@fav_search).serializable_hash,
        status: :unprocessable_entity
      end
  	end

  	def update
      fav_serach_update
      if @fav_search.update(search_params)
        render json: FavouriteSearchSerializer.new(@fav_search)
                         .serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(@fav_search).serializable_hash,
               status: :unprocessable_entity
      end
  	end

    def destroy
      return if @fav_search.nil?

      if @fav_search.destroy
        render json: { success: true }, status: :ok
      else
        render json: ErrorSerializer.new(@fav_search).serializable_hash,
               status: :unprocessable_entity
      end
    end

  	private

    def initilize_fav_search
      if valid_user.present?
        @fav_search = valid_user.favourite_searches.new(search_params)
        @fav_search.food_type = ["Packaged Food"]
      else
        @fav_search = FavouriteSearch.new(search_params)
      end 
      fav_serach_update
    end

    def fav_serach_update
      @fav_search.niq_score = eval(params[:niq_score]) if params[:niq_score].present?
      @fav_search.food_allergies = eval(params[:food_allergies]) if params[:food_allergies].present?
      @fav_search.food_preference = eval(params[:food_preference]) if params[:food_preference].present?
      @fav_search.food_type = eval(params[:food_type]) if params[:food_type].present?
      update_product_count(@fav_search)
    end

    def find_favourite
      @fav_search = FavouriteSearch.find_by(id: params[:id])
    end

  	def search_params
      params.permit(:food_type, :product_category, :product_sub_category, :niq_score, :food_allergies, :food_preference, :functional_preference, :health_preference, :favourite, :account_id, :added_count)
  	end

    def update_product_count(fav_search)
      if fav_search.favourite
        prod = BxBlockCatalogue::SmartSearchService.new.smart_search(fav_search)
        fav_search.product_count = prod.present? ? prod.count : 0
      else
        fav_search.product_count = 0
      end
    end

  end
end
