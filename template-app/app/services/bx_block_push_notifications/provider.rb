module BxBlockPushNotifications
  class Provider
    ONE_SIGNAL = :one_signal.freeze

    SUPPORTED = [ONE_SIGNAL].freeze

    class << self
      def send_push_notification(title:, message:, user_ids:, app_url:)
        provider_klass = case provider_name
                         when ONE_SIGNAL
                           Providers::OneSignal
                         else
                           raise unsupported_message(provider_name)
                         end

        provider_klass.send_push_notification(
          title: title, message: message, user_ids: user_ids, app_url: app_url
        )
      end

      def provider_name
        Rails.configuration.x.push_notifications.provider
      end

      def unsupported_message(provider)
        supported_prov_msg = "Supported: #{SUPPORTED.join(", ")}."
        if provider
          I18n.t('services.bx_block_push_notifications.provider.unsupported_push') + "#{provider}. #{supported_prov_msg}"
        else
          I18n.t('services.bx_block_push_notifications.provider.you_must_specify') + "#{supported_prov_msg}"
        end
      end
    end
  end
end
