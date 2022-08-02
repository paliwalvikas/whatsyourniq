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
    before_create :only_three_record

    def only_three_record
      if AccountBlock::Account.find_by(id: self.account_id).compare_products.where(selected: true).count >= 3
        errors.add(:selected, "You are not able to add more product")
      end
    end

  end
end

