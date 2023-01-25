module BxBlockPushNotifications
  class PushNotification < ApplicationRecord
    require 'fcm'
    self.table_name = :push_notifications

    belongs_to :push_notificable, polymorphic: true
    belongs_to :account, class_name: "AccountBlock::Account"
    validates :remarks, presence:true
    before_create :send_push_notification

    def send_push_notification
      if push_notificable.activated && push_notificable.device_id # && push_notificable.privacy_setting["#{notify_type}".to_sym]
        fcm_client = FCM.new(ENV['FCM_SEVER_KEY'])
        options = { priority: 'high',
                    data: {
                      message: remarks,
                      notify_type: "#{notify_type}",
                      account_id: account_id
                    },
                    notification: {
                    body: remarks,
                    sound: 'default'
                    }
                  }
        registration_id = push_notificable.device_id
        fcm_client.send(registration_id, options)
      end
    rescue Exception => e
      e
    end
  end
end
