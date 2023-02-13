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

end