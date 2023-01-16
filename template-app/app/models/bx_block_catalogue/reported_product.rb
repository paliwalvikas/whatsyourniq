module BxBlockCatalogue
  class ReportedProduct < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reported_products
    belongs_to :account, class_name: "AccountBlock::Account", foreign_key: 'account_id'
    belongs_to :product, class_name: "BxBlockCatalogue::Product", foreign_key: 'product_id'
    enum status: [:pending, :updated]
    after_update :send_email_and_notification,  if: :saved_change_to_status

	def send_email_and_notification
		ReportProductMailer.respond_reported_product(self).deliver_later
	end
  end
end
