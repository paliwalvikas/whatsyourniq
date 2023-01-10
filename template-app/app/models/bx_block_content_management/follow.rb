module BxBlockContentManagement
  class Follow < ApplicationRecord
    self.table_name = :follows
    belongs_to :account, class_name: "AccountBlock::Account"
    validates :account_id, uniqueness: { scope: :content_provider_id,
                                         message: I18n.t('models.bx_block_content_management.follow.content_provider_with_this')}
  end
end
