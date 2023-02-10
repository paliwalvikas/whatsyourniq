module BxBlockPushNotifications
  class SendPushNotification
    attr_reader :title, :message, :user_ids, :app_url

    def initialize(title, message, account)
      @title = title
      @message = message
      @account = account
      @app_url = app_url
      @fcm_client = FCM.new("AAAAjmCG0wg:APA91bF48wEEPJ0p7m6ydOgzOv8B7TxKQ8CsGYicOhrTFN5mQd3vARGn9oFFMxCw8l3FFCc_9fHcO5anefy07HOlO2QsmyqzDXF_x7-sTSHEAv6kvk4eEPP-5xJWKn-sakVVApABKKmR")  #(ENV['FCM_SEVER_KEY'])
    end

    def call
      options =  {
          notification: {
            title: title,
            body: message,
            mutable_content: true,
            sound: "default"
            },

         data: {
         title: title,
            body: message,
            }
        }
     @fcm_client.send(@account.device_id, options)

    end
  end
end
