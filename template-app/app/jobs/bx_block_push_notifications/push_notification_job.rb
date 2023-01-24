module BxBlockPushNotifications
  class PushNotificationJob < ApplicationJob
    queue_as :default
    def perform(title, message, account, notificable)
      BxBlockNotifications::NotificationCreator.new(account.id, title, message, notificable).call
      BxBlockPushNotifications::SendPushNotification.new(title, message, account, notificable).call 
    end
  end
end