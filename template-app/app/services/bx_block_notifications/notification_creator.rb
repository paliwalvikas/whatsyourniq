module BxBlockNotifications
  class NotificationCreator
    attr_accessor :headings,
                  :contents,
                  :account_id

    def initialize(account_id, headings, contents, notificable)
      @headings = headings
      @contents = contents
      @notificable = notificable
      @account_id = account_id
    end

    def call
      @notification = BxBlockNotifications::Notification.create(
          headings: headings,
          contents: contents,
          account_id: account_id,
          notificable: @notificable
      )
    end
  end
end
