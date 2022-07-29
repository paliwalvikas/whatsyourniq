module BxBlockCatalogue
  class FavouriteSearchesController < ApplicationController
    before_action :find_favourite, only: [:update]
    before_action :initilize_fav_search, only: [:create]

    def index
      fav_search = current_user.favourite_searches.all
      if fav_search.present?
        render json: FavouriteSearchSerializer.new(fav_search)
                 .serializable_hash,
        status: :ok
      else
        render json: ErrorSerializer.new(fav_search).serializable_hash,
        status: :unprocessable_entity
      end
    end

  	def create
      if @fav_search .save
        render json: FavouriteSearchSerializer.new(@fav_search)
                 .serializable_hash,
        status: :created
      else
        render json: ErrorSerializer.new(@fav_search).serializable_hash,
        status: :unprocessable_entity
      end
  	end

  	def update
      fav_search = @fav_search.update(search_params)
      if fav_search
        render json: FavouriteSearchSerializer.new(@fav_search)
                         .serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(fav_search).serializable_hash,
               status: :unprocessable_entity
      end
  	end

  	private

    def initilize_fav_search
      @fav_search = current_user.favourite_searches.new(search_params)
      @fav_search.niq_score = eval(params[:niq_score])
      @fav_search.food_allergies = eval(params[:food_allergies])
      @fav_search.food_preference = eval(params[:food_preference])
      @fav_search.health_preference = eval(params[:health_preference])
    end

    def find_favourite
      @fav_search = FavouriteSearch.find_by(id: params[:id])
    end

  	def search_params
      params.permit(:category_id, :product_category, :product_sub_category, :niq_score, :food_allergies, :food_preference, :functional_preference, :health_preference, :favourite, :account_id)
  	end

  end
end
