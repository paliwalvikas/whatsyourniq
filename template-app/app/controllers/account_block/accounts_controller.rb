module AccountBlock
  class AccountsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include BuilderJsonWebToken::JsonWebTokenValidation 
    before_action :validate_json_web_token, only: [:search]

    def create
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account'
        @account = SmsAccount.new(jsonapi_deserialize(params))
        if @account.save
          @sms_otp = SmsOtp.create(full_phone_number: params[:data][:attributes][:full_phone_number])
          render json: SmsAccountSerializer.new(@account, meta: {
            token: encode(@sms_otp.id), pin: @sms_otp.pin
          }).serializable_hash, status: :created
        else
          render json: {errors: format_activerecord_errors(@account.errors)},
          status: :unprocessable_entity
        end

      when 'email_account'
        account_params = jsonapi_deserialize(params)

        query_email = account_params['email'].downcase
        account = EmailAccount.where('LOWER(email) = ?', query_email).first

        validator = EmailValidation.new(account_params['email'])

        return render json: {errors: [
          {account: 'Email invalid'},
        ]}, status: :unprocessable_entity if account || !validator.valid?

        @account = EmailAccount.new(jsonapi_deserialize(params))
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')
        if @account.save
          # EmailAccount.create_stripe_customers(@account)
          EmailValidationMailer 
          .with(account: @account, host: request.base_url)
          .activation_email.deliver
          render json: EmailAccountSerializer.new(@account, meta: {
            token: encode(@account.id),
          }).serializable_hash, status: :created
        else
         render json: {errors:(@account.errors)},
         status: :unprocessable_entity
       end

      when 'social_account'
        account = AccountBlock::SocialAccount.find_by_email(params[:data][:attributes][:email])
        if account.present?
          render json: SocialAccountSerializer.new(account)
        else
          @account = SocialAccount.new(jsonapi_deserialize(params))
          if @account.save
            render json: SocialAccountSerializer.new(@account, meta: {token: encode(@account.id)}).serializable_hash, status: :created
          else

            render json: {errors: (@account.errors)},
            status: :unprocessable_entity
          end
        end
      else
       render json: {errors: [
          {account: 'Invalid Account Type'},
        ]}, status: :unprocessable_entity
      end   
    end   

    def search
      @accounts = Account.where(activated: true)
      .where('first_name ILIKE :search OR '\
       'last_name ILIKE :search OR '\
       'email ILIKE :search', search: "%#{search_params[:query]}%")
      if @accounts.present?
        render json: AccountSerializer.new(@accounts, meta: {message: 'List of users.'
        }).serializable_hash, status: :ok
      else
        render json: {errors: [{message: 'Not found any user.'}]}, status: :ok
      end
    end

    def update
      account = AccountBlock::Account.find_by_id(params[:id])
      if account.present?
        account.update(jsonapi_deserialize(params))
        render json: AccountSerializer.new(account)
      else
        render json: { message: "account not updated" }
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

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def search_params
      params.permit(:query)
    end
  end

end
