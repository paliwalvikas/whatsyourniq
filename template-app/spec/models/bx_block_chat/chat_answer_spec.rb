 require 'rails_helper'

RSpec.describe BxBlockChat::ChatAnswer, type: :model do

  describe 'Associations' do
    it { should belong_to(:account) }
    it { should belong_to(:chat) }
    it { should belong_to(:answer_option).optional }
    it { should have_one_attached(:image) }
  end

end