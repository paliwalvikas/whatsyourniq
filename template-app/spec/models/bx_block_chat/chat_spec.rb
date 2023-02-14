 require 'rails_helper'

RSpec.describe BxBlockChat::Chat, type: :model do

  describe 'Associations' do
    it { should have_many(:chat_answers).dependent(:destroy) }
    it { should have_many(:answer_options).dependent(:destroy) }
  end

  describe "Validations" do 
	it { should validate_presence_of(:chat_type)}
	it { should validate_presence_of(:question)}
  end

   describe "Enum" do
    it { should define_enum_for(:answer_type).with_values({ text: 0 ,number: 1, radio_button: 2, check_box: 3, date_picker: 4, bmi_scale: 5, image_picker: 6 }) }
  end

end