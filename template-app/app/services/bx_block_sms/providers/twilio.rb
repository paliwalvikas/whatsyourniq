module BxBlockSms
  module Providers
    class Twilio
      class << self
        def send_sms(full_phone_number, text_content)
          client = ::Twilio::REST::Client.new(account_id, auth_token)
          client.messages.create({from: from,to: full_phone_number,body: text_content})
        end

        def account_id
          # Rails.configuration.x.sms.account_id
          ENV["ACCOUNT_ID_TWILIO"] 
        end

        def auth_token
          # Rails.configuration.x.sms.auth_token
          ENV["SCREATE_KEY_TWILIO"] 
        end

        def from
          ENV["FROM_NUMBER"]
        end
      end
    end
  end
end
