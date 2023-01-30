# frozen_string_literal: true

module BxBlockTermsAndConditions
  class TermsAndConditionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token
    
    def terms_and_conditions
      terms_and_conditions = BxBlockTermsAndConditions::TermsAndConditions.all

      if terms_and_conditions.any?
        render json: TermsAndConditionsSerializer.new(terms_and_conditions).serializable_hash, status: :ok
      else
        render json: { message: I18n.t('controllers.bx_block_terms_and_conditions.terms_and_conditions_controller.terms_and_conditions_not_exist') }, status: :unprocessable_entity
      end
    end
  end
end
