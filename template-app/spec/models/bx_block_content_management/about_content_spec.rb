require 'rails_helper'

RSpec.describe BxBlockContentManagement::AboutContent, type: :model do
  describe 'AboutContent#model' do
    let!(:about_content) { create(:about_content) }

    it "should about_content present" do
      expect(:about_content).not_to be_nil
    end
  end
end

