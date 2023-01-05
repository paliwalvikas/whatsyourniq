module BxBlockFaqAndContactUs
  class ContactUsMailer < ApplicationMailer
    def contact_us_email(account)
      @account = account
      if @account.contact_type == 'contact_type'
        mail(
            to: 'consumer@superfoodsvalley.com',
            from: @account.email,
            subject: 'Contact Request') do |format|
              format.html { render 'contact_us_email' }
            end
      elsif @account.contact_type == 'for_business_enterprise'
          mail(
            to: 'business@superfoodsvalley.com',
            from: @account.email,
            subject: 'Contact Request') do |format|
              format.html { render 'contact_us_email' }
            end
      end

    end

  end
end
