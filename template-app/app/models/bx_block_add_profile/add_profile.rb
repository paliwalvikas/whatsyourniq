module BxBlockAddProfile
  class AddProfile < BxBlockCatalogue::ApplicationRecord
    self.table_name = :add_profiles
    
    validates :full_name, :age, :email, :height, :weight, :address, :pincode, :city, :state, :activity_level, :gender, :contact_no, presence: true
    validates :contact_no, phone: true ,uniqueness: true
    validates :email, uniqueness: true
    enum gender: %i[female male other]
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

