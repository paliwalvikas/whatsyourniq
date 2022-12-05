 require 'rails_helper'

RSpec.describe BxBlockAddProfile::AddProfile, type: :model do
 	describe 'Associations' do
    it { should belong_to(:account) }
    it { should belong_to(:relation) }
    it { should have_one_attached(:image) }
	end

	describe "Validations" do 
		it { should validate_presence_of(:full_name)}
		it { should validate_presence_of(:age) }
		it { should validate_presence_of(:height) }
		it { should validate_presence_of(:weight) }
		it { should validate_presence_of(:address) }
		it { should validate_presence_of(:pincode) }
		it { should validate_presence_of(:city) }
		it { should validate_presence_of(:state) }
		it { should validate_presence_of(:activity_level) }
		it { should validate_presence_of(:gender) }
	end

  describe "Enum" do
    it { should define_enum_for(:gender).with_values([:female, :male, :other]) }
	end

	describe "Enum" do
	   it { should define_enum_for(:activity_level).with_values([:high, :medium, :low]) }
	end

	describe "Enum" do
	   it { should define_enum_for(:bmi_status).with_values({
														      under_weight: 0,
														      normal_weight_range_for_asians: 1,
														      overweight_at_risk: 2,
														      obese_grade_1: 3,
														      obese_grade_2: 4
														    })}
	end
  let(:add_profile) { FactoryBot.create(:add_profile) }

  describe 'runs calculate_bmi ' do 
    it 'runs calculate_bmi ' do
      add_profile.update(bmi_status: 1) do
        add_profile.run_callbacks(:validation)
      end
    end
  end
end