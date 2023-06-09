module BxBlockCatalogue
  class RequestedProduct < BxBlockCatalogue::ApplicationRecord
    self.table_name = :requested_products
    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :category, class_name: 'BxBlockCategories::Category', foreign_key: 'category_id', optional: true
    enum status: %i[pending rejected approved]
    has_many_attached :product_image
    has_many_attached :barcode_image
    validates :status, presence: true, allow_blank: false

    after_update :send_notifications, if: :saved_change_to_status

    private

    def send_notifications
      RequestedProductMailer.update_product_status(self).deliver_later
      BxBlockPushNotifications::PushNotificationJob.perform_now('Requested Product',
                                                                'Submitted Product status has been changed', account, self)
    end
  end
end
