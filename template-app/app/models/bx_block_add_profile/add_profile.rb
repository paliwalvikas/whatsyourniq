module BxBlockAddProfile
  class AddProfile < BxBlockCatalogue::ApplicationRecord
    self.table_name = :add_profiles
    
    validates_presence_of :full_name, :age, :height, :weight, :address, :pincode, :city, :state, :activity_level, :gender, on: :create
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

    enum bmi_status: {
      under_weight: 0,
      normal_weight_range_for_asians: 1,
      overweight_at_risk: 2,
      obese_grade_1: 3,
      obese_grade_2: 4
    }

  end
end

