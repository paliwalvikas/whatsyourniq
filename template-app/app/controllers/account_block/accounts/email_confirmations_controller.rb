# frozen_string_literal: true

module AccountBlock
  module Accounts
    class EmailConfirmationsController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation

      before_action :validate_json_web_token

      def show
        begin
          @account = EmailAccount.find(@token.id)
        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors: [
            {account: I18n.t('controllers.account_block.accounts.account_not_found')},
          ]}, status: :unprocessable_entity
        end

        if @account.activated?
          return render json: ValidateAvailableSerializer.new(@account, meta: {
            message: I18n.t('controllers.account_block.accounts.account_already_activated'),
          }).serializable_hash, status: :ok
        end

        @account.update :activated => true

        render json: ValidateAvailableSerializer.new(@account, meta: {
          message: I18n.t('controllers.account_block.accounts.account_activated_successfully'),
        }).serializable_hash, status: :ok
      end
    end
  end
end
