# frozen_string_literal: true

module BxBlockContentManagement
  class AboutContentsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token
    
    def about_us_contents
      about_contents = BxBlockContentManagement::AboutContent.all

      if about_contents.any?
        render json: AboutContentSerializer.new(about_contents).serializable_hash, status: :ok
      else
        render json: { message: I18n.t('controllers.bx_block_content_management.about_contents_controller.about_content_not_exist') }, status: :unprocessable_entity
      end
    end
  end
end
