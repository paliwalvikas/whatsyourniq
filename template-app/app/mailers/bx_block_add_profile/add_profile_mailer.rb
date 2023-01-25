module BxBlockAddProfile
  class AddProfileMailer < ApplicationMailer

    def new_family_member(user, new_member)
      @user = user
      @new_member = new_member

      mail(to: @user.email, subject: "New member is added!")
    end
  end
end

