module BxBlockFaqAndContactUs
  class ContactUsMailer < ApplicationMailer
    def contact_us_email(account)
      @account = account
      if @account.contact_type == 'contact_type'
        mail(
            to: 'consumer@superfoodsvalley.com',
            from: @account.email,
            subject: 'Thank you for contact us') do |format|
              format.html { render 'contact_us_email' }
            end
      elsif @account.contact_type == 'for_business_enterprise'
          mail(
            to: 's1214@yopmail.com',
            from: @account.email,
            subject: 'Thank you for contact us') do |format|
            byebug
              format.html { render 'contact_us_email' }
            end
      end

    end

  end
end