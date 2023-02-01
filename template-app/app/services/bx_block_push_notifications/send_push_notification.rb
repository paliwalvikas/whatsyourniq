module BxBlockPushNotifications
  class SendPushNotification
    attr_reader :title, :message, :user_ids, :app_url

    def initialize(title, message, account)
      @title = title
      @message = message
      @account = account
      @app_url = app_url
      @fcm_client = FCM.new(FCM.new(ENV['FCM_SEVER_KEY']))
    end

    def call
      options = { title: title,
                  message: message,
                }
      @fcm_client.send(@account.device_id, options)
    end
  end
end
