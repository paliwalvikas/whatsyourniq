 require 'rails_helper'

RSpec.describe BxBlockChat::AnswerOption, type: :model do

  describe 'Associations' do
    it { should belong_to(:chat) }
    it { should have_many(:chat_answers).dependent(:destroy) }
  end

  describe "Validations" do 
		it { should validate_presence_of(:option)}
	end

end