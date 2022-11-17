module BxBlockFaqAndContactUs
  class FaqsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    
    skip_before_action :validate_json_web_token, only: %i[index show]
    before_action :find_faq, only: %i[show]

    def index
      render json: FaqSerializer.new(Faq.all).serializable_hash, status: :ok
    end

    def show
      if @faq.present?
        render json: FaqSerializer.new(@faq).serializable_hash, status: :ok
      else
        render json: {errors: [
          {success: false, message: "No record found"},
        ]}, status: :ok
      end
    end

    def destroy
      if @faq.destroy
        render json: {message: "Record Successfully Deleted."}, status: :ok
      else
        render json: {message: "Record not found."}
      end
    end

    private

    def find_faq
      @faq = Faq.find_by_id(params[:faq_id] || params[:id])
    end

  end
end
