module BxBlockFollowers
  class FollowsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :current_user
    before_action :validate_params, only: [:create]

    def index
      #get list of following
      @followers = Follow.where('current_user_id = ?', current_user.id)

      authorize Follow

      if @followers.present?
        render json: FollowSerializer.new(@followers, meta: {message: I18n.t('controllers.bx_block_followers.follows_controller.list_following_users')
        }).serializable_hash, status: :ok
      else
        render json: {errors: [{message: I18n.t('controllers.bx_block_followers.follows_controller.not_following_user')}]}, status: :ok
      end
    end

    def show
      #Check if you follow this user
      @account = Follow.find_by(
        current_user_id: current_user.id,
        account_id: params[:id])
      if @account.present?
        authorize @account
        render json: FollowSerializer.new(@account,
                                          meta: {success: true, message: I18n.t('controllers.bx_block_followers.follows_controller.following_this_user')
                                          }).serializable_hash, status: :ok
      else
        render json: {errors: [
          {success: false, message: I18n.t('controllers.bx_block_followers.follows_controller.not_following_this_user')},
        ]}, status: :ok
      end
    end

    def create
      follow_params = jsonapi_deserialize(params)
      followable_id = follow_params['account_id']
      follow = Follow.find_by(current_user_id: current_user.id, account_id: followable_id)
      return render json: {errors: [
        {message: I18n.t('controllers.bx_block_followers.follows_controller.you_already_follow')},
      ]}, status: :unprocessable_entity if follow.present?
      #Check if user you want to follow does not exists
      @account = AccountBlock::Account.find_by(id: followable_id, activated: true)
      return render json: {errors: [
        {message: I18n.t('controllers.bx_block_followers.follows_controller.user_does_not_exist')},
      ]}, status: :unprocessable_entity unless @account.present?

      #If user try to follow self
      return render json: {errors: [
        {message: I18n.t('controllers.bx_block_followers.follows_controller.you_not_follow_yourself')},
      ]}, status: :unprocessable_entity if current_user.id == followable_id.to_i
      @follow = Follow.new(follow_params)
      authorize @follow
      @follow.current_user_id = current_user.id
      if @follow.save
        render json: FollowSerializer.new(@follow, meta: {
          message: I18n.t('controllers.bx_block_followers.follows_controller.successfully_followed')}).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@follow.errors)},
               status: :unprocessable_entity
      end
    end

    def destroy
      @follow = Follow.find_by(id: params[:id])
      return render json: {errors: [
        {message: I18n.t('controllers.bx_block_followers.follows_controller.not_following_this_user')},
      ]}, status: :unprocessable_entity if !@follow.present?
      if @follow.destroy
        render json: {message: I18n.t('controllers.bx_block_followers.follows_controller.successfully_unfollowed')}, status: :ok
      else
        render json: {errors: format_activerecord_errors(@follow.errors)},
               status: :unprocessable_entity
      end
    end

    private

    def validate_params
      return render json: {errors: [
        {message: I18n.t('controllers.bx_block_followers.follows_controller.parameter_missing')},
      ]}, status: :unprocessable_entity if params[:data][:attributes][:account_id].nil?
    end
  end
end
