module BxBlockSms
  module Providers
    class Twilio
      class << self
        def send_sms(full_phone_number, text_content)
          client = ::Twilio::REST::Client.new(account_id, auth_token)
          client.messages.create({from: "+13512137366",to: full_phone_number,body: text_content})
        end

        def account_id
          # Rails.configuration.x.sms.account_id
          ENV["account_id"] || "AC2bfa27273d30e27e3264af606ee8a0ab"
        end

        def auth_token
          # Rails.configuration.x.sms.auth_token
          ENV["auth_token"] || "7b8ae648de343824ce3fc20bce6062f7"
        end

        # def from
        #   "+7083607819"
        # end
      end
    end
  end
end
