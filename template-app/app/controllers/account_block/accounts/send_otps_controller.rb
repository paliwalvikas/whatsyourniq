# frozen_string_literal: true

module AccountBlock
  module Accounts
    class SendOtpsController < ApplicationController
      
      def create
        json_params = jsonapi_deserialize(params)
        account = SmsAccount.find_by(
          full_phone_number: json_params['full_phone_number'],
          activated: true)

        return render json: {errors: [{
          account: I18n.t('controllers.account_block.accounts.account_already_activated'),
        }]}, status: :unprocessable_entity unless account.nil?

        @sms_otp = SmsOtp.new(jsonapi_deserialize(params))
        if @sms_otp.save
          render json: SmsOtpSerializer.new(@sms_otp, meta: {
            token: BuilderJsonWebToken.encode(@sms_otp.id), pin: @sms_otp.pin,
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@sms_otp.errors)},
            status: :unprocessable_entity
        end
      end

      private

      def format_activerecord_errors(errors)
        result = []
        errors.each do |attribute, error|
          result << { attribute => error }
        end
        result
      end
    end
  end
end
