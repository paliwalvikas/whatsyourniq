module BxBlockNotifications
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => [I18n.t('controllers.builder_base.application_controller.record_not_found')]}, :status => :not_found
    end

    def current_user
      begin
        @current_user = AccountBlock::Account.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors: [
            {message: I18n.t('controllers.bx_block_notifications.application_controller.please_login_again')},
        ]}, status: :unprocessable_entity
      end
    end
  end
end
