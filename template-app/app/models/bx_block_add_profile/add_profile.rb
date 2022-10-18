module BxBlockAddProfile
  class AddProfile < BxBlockCatalogue::ApplicationRecord
    self.table_name = :add_profiles
    
    validates :full_name, :age, :email, :height, :weight, :address, :pincode, :city, :state, :activity_level, :contact_no, :relation_id, presence: true
    validates :contact_no, uniqueness: true, length: {is: 10}
    validates :email, uniqueness: true
    
    belongs_to :relation, 
                class_name: 'BxBlockAddProfile::Relation',
                foreign_key: 'relation_id'

    belongs_to :account, 
              class_name: 'AccountBlock::Account',
              foreign_key: 'account_id'

    enum activity_level: %i[high medium low]
    has_one_attached :image

  end
end

