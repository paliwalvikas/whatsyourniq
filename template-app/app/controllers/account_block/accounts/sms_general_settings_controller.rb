# frozen_string_literal: true

module AccountBlock
  module Accounts
    class SmsGeneralSettingsController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation

      before_action :validate_json_web_token

      def create
        begin
          @sms_otp = SmsOtp.find(@token.id)
        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors: [
            {phone: I18n.t('controllers.account_block.accounts.phone_not_found')},
          ]}, status: :unprocessable_entity
        end
        if @sms_otp.valid_until < Time.current
          @sms_otp.destroy

          return render json: {errors: [
            {pin: I18n.t('controllers.account_block.accounts.pin_has_expired')},
          ]}, status: :unauthorized
        end

        if @sms_otp.activated?
          return render json: ValidateAvailableSerializer.new(@sms_otp, meta: {
            message: I18n.t('controllers.account_block.accounts.phone_already_activated'),
          }).serializable_hash, status: :ok
        end

        if @sms_otp.pin.to_s == params[:data][:attributes]['pin'].to_s
          @sms_otp.activated = true
          @sms_otp.save
          @account = AccountBlock::Account.find_by(id: params[:id])
          @account.update(device_id: params[:data][:attributes][:device_id], full_phone_number: @sms_otp.full_phone_number )
          @account.additional_details = true unless @account&.full_name.nil?
          render json: SmsAccountSerializer.new(@account, meta: {
            message: I18n.t('controllers.account_block.accounts.phone_confirmed_successfully'),
            token: BuilderJsonWebToken.encode(@account.id), register: @account.register, additional_details: @account.additional_details
          }).serializable_hash, status: :ok
        else
          return render json: {errors: [
            {pin: I18n.t('controllers.account_block.accounts.invalid_pin_phone')},
          ]}, status: :unprocessable_entity
        end
      end
    end
  end
end
