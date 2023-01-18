module BxBlockSms
  class Provider
    TWILIO = :twilio.freeze
    KARIX = :karix.freeze
    TEST = :test.freeze

    SUPPORTED = [TWILIO, KARIX, TEST].freeze

    class << self
      def send_sms(to, text_content)
        provider_klass = case provider_name
                         when "TWILIO"
                           Providers::Twilio
                         when "KARIX"
                           Providers::Karix
                         when "TEST"
                           Providers::Test
                         else
                           raise unsupported_message(provider_name)
                         end

        provider_klass.send_sms(to, text_content)
      end

      def provider_name
        ENV["PROVIDER"] || "TEST"
      end

      def unsupported_message(provider)
        supported_prov_msg = I18n.t('services.bx_block_sms.provider.supported') + "#{SUPPORTED.join(", ")}."
        if provider
          I18n.t('services.bx_block_sms.provider.unsupported_sms') + "#{provider}. #{supported_prov_msg}"
        else
          I18n.t('services.bx_block_sms.provider.you_must_specify_provider') + "#{supported_prov_msg}"
        end
      end
    end
  end
end
