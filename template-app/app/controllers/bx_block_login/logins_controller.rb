module BxBlockLogin
  class LoginsController < BxBlockLogin::ApplicationController
    skip_before_action :verify_authenticity_token
    
    def create
      case params[:data][:type] #### rescue invalid API format
      when 'email_account'
        @account = AccountBlock::EmailAccount.find_by_email(params[:data][:attributes][:email])
        if @account.present?
          if @account.authenticate(params[:data][:attributes][:password])
           if check_account_activated
             user = AccountBlock::EmailAccountSerializer.new(@account)
           end
         else
          render json: { errors: I18n.t('controllers.bx_block_login.logins_controller.invalid_password') }
        end 
      else 
        render json: { errors: I18n.t('controllers.bx_block_forgot_password.otps_controller.account_not_found') }
      end 

      when 'social_account'
        @account = AccountBlock::SocialAccount.where("unique_auth_id = ? or email = ? or platform = ? ", params[:data][:attributes][:unique_auth_id], params[:data][:attributes][:email],  params[:data][:attributes][:platform]).first
        if @account
          check_account_activated
        else
          render json: { errors: I18n.t('controllers.bx_block_forgot_password.otps_controller.account_not_found') }
        end

      when 'sms_account'
        account = OpenStruct.new(jsonapi_deserialize(params))
        account.type = params[:data][:type]
        output = AccountAdapter.new

        output.on(:account_not_found) do |account|
          render json: {
            errors: [{
              failed_login: I18n.t('controllers.bx_block_login.logins_controller.account_not_found_activated'),
            }],
          }, status: :unprocessable_entity
        end

        output.on(:failed_login) do |account|
          render json: {
            errors: [{
              failed_login: I18n.t('controllers.bx_block_login.logins_controller.login_failed'),
            }],
          }, status: :unauthorized
        end

        output.on(:successful_login) do |account, token, refresh_token|
          render json: {meta: {
            token: token,
            refresh_token: refresh_token,
            id: account.id
          }}
        end

        output.login_account(account)
      else
        render json: {
          errors: [{
            account: I18n.t('controllers.bx_block_login.logins_controller.invalid_account_type'),
          }],
        }, status: :unprocessable_entity
      end
    end
  
    private

    def check_account_activated
      if @account.activated == true
        @account.flag = true
        if @account.type == 'EmailAccount'
          user = AccountBlock::EmailAccountSerializer.new(@account)
        else 
          user = AccountBlock::SocialAccountSerializer.new(@account)
        end 
        render json: {user: user, meta: {token: encode(@account.id)}}
      else
        render json: { errors: I18n.t('controllers.bx_block_login.logins_controller.your_account_not_verfied'), id: @account.id}
      end
    end

    def encode(id)
      BuilderJsonWebToken.encode id
    end 
  end
end