module BxBlockContentManagement
  class AboutContentsController < ApplicationController
    def about_us_contents
      about_contents = BxBlockContentManagement::AboutContent.all
      
      if about_contents.any?
        render json: AboutContentSerializer.new(about_contents).serializable_hash, status: :ok
      else
        render json: { message: "About us content does not exist." }, status: :unprocessable_entity
      end
    end
  end
end