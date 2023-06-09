module BxBlockFaqAndContactUs
  class ContactUsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    
    skip_before_action :validate_json_web_token, only: %i[create index show]

    def index
      contact_us = ContactUs.all
      render json: ContactUsSerializer.new(contact_us)
    end

    def create
      contact_us = ContactUs.new(con_us_params)
      if contact_us.save
        ContactUsMailer.with(contact_us).contact_us_email(contact_us).deliver
        render json: ContactUsSerializer.new(contact_us),
                      status: :created, message: I18n.t('controllers.bx_block_faq_and_contact_us.contact_us_controller.thank_you_contact_us')
      else
        render json: { error: contact_us.errors }
      end
    end

    private

    def con_us_params
      params.permit(:contact_type, :business_name, :name, :email, :contact_no, :message)
    end
  end
end
