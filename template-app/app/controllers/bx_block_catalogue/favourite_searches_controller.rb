module BxBlockCatalogue
  class FavouriteSearchesController < ApplicationController
    before_action :find_favourite, only: [:update]

    def index
      fav_search = current_user.favourite_searches.all
      if fav_search.present?
        render json: FavouriteSearchSerializer.new(fav_search)
                 .serializable_hash,
        status: :created
      else
        render json: ErrorSerializer.new(fav_search).serializable_hash,
        status: :unprocessable_entity
      end
    end

  	def create
      fav_search = current_user.favourite_searches.new(search_params)
      if fav_search.save
        render json: FavouriteSearchSerializer.new(fav_search)
                 .serializable_hash,
        status: :created
      else
        render json: ErrorSerializer.new(fav_search).serializable_hash,
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

    def find_favourite
      @fav_search = FavouriteSearch.find_by(id: params[:id])
    end

  	def search_params
      params.permit(:category_id, :product_category, :product_sub_category, :niq_score, :food_allergies, :food_preference, :functional_preference, :health_preference, :favourite, :account_id)
  	end

  end
end
