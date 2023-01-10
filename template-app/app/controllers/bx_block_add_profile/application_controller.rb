module BxBlockAddProfile
  class ApplicationController < BuilderBase::ApplicationController
 
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private
    
    def not_found
      return render :json => {'errors' => [I18n.t('controllers.builder_base.application_controller.record_not_found')]}, :status => :not_found
    end

    def current_user
      return unless @token
      @current_user ||= AccountBlock::Account.find_by(id: @token&.id)
    end
  end
end
