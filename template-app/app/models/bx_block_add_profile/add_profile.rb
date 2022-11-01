module BxBlockAddProfile
  class AddProfile < BxBlockCatalogue::ApplicationRecord
    self.table_name = :add_profiles

    belongs_to :relation, 
                class_name: 'BxBlockAddProfile::Relation',
                foreign_key: 'relation_id'

    belongs_to :account, 
              class_name: 'AccountBlock::Account',
              foreign_key: 'account_id'

    has_one_attached :image
    
    validates :full_name, :age, :height, :weight, :address, :pincode, :city, :state, :activity_level, :gender, presence: true, on: :create
    validates :contact_no, phone: true ,uniqueness: true
    validates :email, uniqueness: true
    
    enum gender: %i[female male other]
    enum activity_level: %i[high medium low]
    
    enum bmi_status: {
      under_weight: 0,
      normal_weight_range_for_asians: 1,
      overweight_at_risk: 2,
      obese_grade_1: 3,
      obese_grade_2: 4
    }

  end
end

