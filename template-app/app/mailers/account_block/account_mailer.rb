module AccountBlock
  class AccountMailer < ApplicationMailer
    def send_welcome_mail(account)
      @user = account

      mail(to: @user.email, subject: "Welcome email")
    end

    def update_profile(account)
      @user = account

      mail(to: @user.email, subject: "Profile Updated!")
    end
  end
end

