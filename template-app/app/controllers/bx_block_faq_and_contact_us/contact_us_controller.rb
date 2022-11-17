module BxBlockFaqAndContactUs
  class ContactUsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    
    # skip_before_action :validate_json_web_token, only: %i[create index show]

    def create
      # contact_us = ContactUs.new(con_us_params)
      # if contact_us.save
      #   render json: ContactUsSerializer.new(contact_us),
      #                 status: :created
      # else
      #   render json: { error: contact_us.errors }
      # end
    end

    private

    # def con_us_params
    #   params.permit(:type, :business_name, :name, :email, :contact_no, :message)
    # end
  end
end
