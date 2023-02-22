# frozen_string_literal: true

module BxBlockAddProfile
  class AddProfile < BxBlockCatalogue::ApplicationRecord
    self.table_name = :add_profiles

    belongs_to :relation,
               class_name: 'BxBlockAddProfile::Relation',
               foreign_key: 'relation_id'

    belongs_to :account,
               class_name: 'AccountBlock::Account',
               foreign_key: 'account_id'

    has_many :chat_answers, 
              class_name: 'BxBlockChat::ChatAnswer', 
              dependent: :destroy

    has_one_attached :image

    validates :full_name, :age, :height, :weight, :address, :pincode, :city, :state, :activity_level, :gender,
              presence: true, on: :create
    validates :contact_no, phone: true, uniqueness: true
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

    before_save :calculate_bmi

    private

    def calculate_bmi
      self.bmi_result = BmiCalculator.calc_m height, weight

      if bmi_result < 18.50
        self.bmi_status = 0
      elsif (bmi_result >= 18.51) && (bmi_result <= 22.90)
        self.bmi_status = 1
      elsif (bmi_result >= 22.91) && (bmi_result <= 24.90)
        self.bmi_status = 2
      elsif (bmi_result >= 24.91) && (bmi_result <= 29.90)
        self.bmi_status = 3
      elsif bmi_result >= 29.91
        self.bmi_status = 4
      end
    end
  end
end
