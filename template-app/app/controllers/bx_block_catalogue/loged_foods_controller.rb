# frozen_string_literal: true

module BxBlockCatalogue
  class LogedFoodsController < ApplicationController
    before_action :validate_json_web_token
    before_action :load_loged_food, only: %i[update destroy copy_loged_food]

    def create
      loged_food = current_user.loged_foods.new(loged_food_params)
      if loged_food.save
        render json: LogedFoodSerializer.new(loged_food)
      else
        render json: { errors: 'Food not loged please try again' }, status: :unprocessable_entity
      end
    end

    def index
      loged_foods = current_user.loged_foods
      if loged_foods.present?
        render json: loged_food_response(loged_foods)
      else
        render json: { errors: 'No loged food found please add food in log food' }, status: :unprocessable_entity
      end
    end

    def update
      return if @loged_food.nil?

      loged_food = @loged_food.update(loged_food_params)
      if loged_food
        render json: LogedFoodSerializer.new(@loged_food)
      else
        render json: ErrorSerializer.new(@loged_food).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def destroy
      return if @loged_food.nil?

      if @loged_food.destroy
        render json: { success: true }, status: :ok
      else
        render json: ErrorSerializer.new(@catalogue).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def copy_loged_food
      return if @loged_food.nil?

      loged_food = @loged_food.dup
      loged_food.save
      if loged_food.present?
        render json: LogedFoodSerializer.new(loged_food)
      else
        render json: { errors: 'Record not created please try again' }, status: :unprocessable_entity
      end
    end

    private

    def loged_food_params
      params.permit(:product_id, :quantity, :food_type, :default_time)
    end

    def loged_food_response(loged_foods)
      breakfast = loged_foods.where(food_type: 'breakfast')
      lunch = loged_foods.where(food_type: 'lunch')
      dinner = loged_foods.where(food_type: 'dinner')
      snacks = loged_foods.where(food_type: 'snacks')
      { breakfast_food_count: breakfast.count,
        breakfast: LogedFoodSerializer.new(breakfast),
        lunch_food_count: lunch.count,
        lunch: LogedFoodSerializer.new(lunch),
        dinner_food_count: dinner.count,
        dinner: LogedFoodSerializer.new(dinner),
        snacks_food_count: snacks.count,
        snacks: LogedFoodSerializer.new(snacks) }
    end

    def load_loged_food
      @loged_food = current_user.loged_foods.find_by_id(params[:id])
      return unless @loged_food.nil?

      render json: { errors: 'Food not found in loged food please add first' }, status: :not_found
    end
  end
end
