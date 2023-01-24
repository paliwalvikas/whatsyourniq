module BxBlockCatalogue
  class OrderMailer < ApplicationMailer

    def add_healthy_food_basket(order)
      @order = order
      @user = @order.account

      mail(to: @user.email, subject: "Healthy basket is added!")
    end

    def remove_healthy_food_basket(order)
      @order = order
      @user = @order.account

      mail(to: @user.email, subject: "Healthy basket is removed!")
    end
  end
end
