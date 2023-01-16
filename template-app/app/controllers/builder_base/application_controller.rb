module BuilderBase
  class ApplicationController < ::ApplicationController
    include JSONAPI::Deserialization
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def not_found
      render :json => {'errors' => [I18n.t('controllers.builder_base.application_controller.record_not_found')]}, :status => :not_found
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port } }
    end
    
    def page_params
      params.permit(:page, :per)
    end

    before_action :set_locale
    
    private

    def set_locale
      I18n.locale = extract_locale
    end
    
    def extract_locale
      if params[:language_id]&.present?
        BxBlockLanguageOptions::Language.find(params[:language_id]).locale
      else
        I18n.default_locale.to_s
      end
    end
  end
end
