# frozen_string_literal: true

module AccountBlock
  class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, only: [:index]

    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account'
        account = SmsAccount.find_by(full_phone_number: params[:data][:attributes][:full_phone_number])
        sms_otp = sms_otp_pin
        if account.present?
          account.register = true
          render json: SmsAccountSerializer.new(account, meta: {
                                                  token: encode(sms_otp.id), pin: sms_otp.pin, register: account.register
                                                }).serializable_hash, status: :created
        else
          account = SmsAccount.new(full_phone_number: params[:data][:attributes][:full_phone_number])
          if account.save
            render json: SmsAccountSerializer.new(account, meta: {
                                                    token: encode(sms_otp.id), pin: sms_otp.pin
                                                  }).serializable_hash, status: :created
          else
            render json: { errors: format_activerecord_errors(account.errors) },
                   status: :unprocessable_entity
          end
        end

      when 'social_account'
        account = SocialAccount.find_by(email: params[:data][:attributes][:email])
        if account.present?
          account.register = true
          account.additional_details = true unless account.full_name.nil?
          render json: SocialAccountSerializer.new(account, meta: { token: encode(account.id), message: 'Account already registered', register: account.register, additional_details: account.additional_details }),
                 status: :ok
        else
          account = SocialAccount.new(social_params)
          if account.save
            render json: SocialAccountSerializer.new(account, meta: { token: encode(account.id), register: account.register }).serializable_hash,
                   status: :created
          end
        end
      else
        render json: { errors: [
          { account: 'Invalid Account Type' }
        ] }, status: :unprocessable_entity
      end
    end

    def update
      account = AccountBlock::Account.find_by_id(params[:id])
      if account.present?
        account.update(update_params)
        account.additional_details = true
        render json: AccountSerializer.new(account, meta: { message: 'Account updated successfully', additional_details: account.additional_details }),
               status: :ok
      else
        render json: { message: 'account not updated' }
      end
    end

    def show
      account = AccountBlock::Account.find_by_id(params[:id])
      render json: AccountSerializer.new(account)
    end

    private

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def update_params
      params.require(:data).require(:attributes).permit(:full_name, :full_phone_number, :email, :activated, :image,
                                                        :gender)
    end

    def social_params
      params.require(:data).require(:attributes).permit(:full_name, :full_phone_number, :email, :activated, :image_url,
                                                        :gender, :unique_auth_id)
    end

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def sms_otp_pin
      sms_otp = SmsOtp.create(full_phone_number: params[:data][:attributes][:full_phone_number], hash_key: params[:data][:attributes][:hash_key])
    end
  end
end
