module BxBlockCatalogue
  class RequestedProductMailer < ApplicationMailer
    def send_product_status(requested_product)
      @requested_product = requested_product
      @user = @requested_product.account

      mail(to: @user.email, subject: 'New Requested Product!')
    end

    def update_product_status(requested_product)
      @requested_product = requested_product
      @user = @requested_product.account

      mail(to: @user.email, subject: 'Update for your Submitted Product!')
    end
  end
end
