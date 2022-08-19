module BxBlockCatalogue
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private
    
    def not_found
      return render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    def current_user
      return unless @token
      @current_user ||= AccountBlock::Account.find(@token.id)
    end

    def valid_user
      token = request.headers[:token] || params[:token]
      if token.present?
        validate_json_web_token
        AccountBlock::Account.find_by(id: @token&.id)
      end
    end
  end
end
