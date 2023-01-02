module BxBlockChat
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

	 	def serialization_options
			{ params: { host: request.protocol + request.host_with_port } }
 		end

 		def current_user
      return unless @token
      @current_user ||= AccountBlock::Account.find(@token.id)
    end

    private

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end
  end
end
