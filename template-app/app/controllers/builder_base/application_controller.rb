module BuilderBase
  class ApplicationController < ::ApplicationController
    include JSONAPI::Deserialization
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end
    
    def page_params
      params.permit(:page, :per)
    end

  end
end
