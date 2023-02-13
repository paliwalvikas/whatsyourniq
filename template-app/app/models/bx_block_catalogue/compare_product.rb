module BxBlockCatalogue
  class CompareProduct < BxBlockCatalogue::ApplicationRecord
    self.table_name = :compare_products
    belongs_to :account,
                class_name: 'AccountBlock::Account',
                foreign_key: 'account_id'
    belongs_to :product,
                class_name: 'BxBlockCatalogue::Product',
                foreign_key: 'product_id'

    validates :product_id, uniqueness: {scope: [:account_id]}
    validate :compare_products_limit

    def compare_products_limit 
      if AccountBlock::Account.find_by(id: self.account_id).compare_products.where(selected: true).count >= 5
        errors.add(:selected, I18n.t('models.bx_block_catalogue.compare_product.you_are_not_able'))
      end
    end

  end
end

