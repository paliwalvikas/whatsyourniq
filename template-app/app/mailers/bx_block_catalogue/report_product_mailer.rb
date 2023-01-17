module BxBlockCatalogue
  class ReportProductMailer < ApplicationMailer

    def respond_reported_product(reported_product)
      @reported_product = reported_product
      @user = @reported_product.account

      mail(to: @user.email, subject: "Update for your Reported Product!")
    end
  end
end
