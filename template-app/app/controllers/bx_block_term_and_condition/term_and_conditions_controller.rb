# frozen_string_literal: true

module BxBlockTermAndCondition
  class TermAndConditionsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token
    
    def term_and_conditions
      term_and_conditions = BxBlockTermAndCondition::TermAndCondition.all

      if term_and_conditions.any?
        render json: TermAndConditionSerializer.new(term_and_conditions).serializable_hash, status: :ok
      else
        render json: { message: I18n.t('controllers.bx_block_term_and_condition.term_and_conditions_controller.term_and_conditions_not_exist') }, status: :unprocessable_entity
      end
    end
  end
end
