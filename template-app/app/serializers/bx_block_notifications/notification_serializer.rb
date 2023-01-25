module BxBlockNotifications
  class NotificationSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
        :id,
        :created_by,
        :headings,
        :contents,
        :app_url,
        :is_read,
        :read_at,
        :created_at,
        :updated_at,
        :account,
    ]

    attributes :notificable do |obj|
      obj&.notificable
    end
  end
end
