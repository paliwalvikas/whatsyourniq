require 'rails_helper'

RSpec.describe BxBlockAddProfile::AddProfilesController, type: :controller do
  let (:add_profile) {FactoryBot.create(:add_profile)}

  before do
    @account = add_profile.account
    @token = BuilderJsonWebToken.encode(@account.id)
  end

  describe "Post 'create' Add Profile" do
  	it 'Create Add Profile' do
      expect do
        post :create, params: {token: BuilderJsonWebToken.encode( FactoryBot.create(:social_account).id), :full_name => "Prity Soni", :age => 25, :gender => 'female', :email => Faker::Internet.email , :height => 5.90, :weight => 50.34, :address => Faker::Address.full_address, :pincode => '460001',
        :city => 'betul', :state => "Madhya Pradesh", :activity_level => 'high', :contact_no => Faker::Base.numerify('+91##########'), :relation_id => FactoryBot.create(:relation).id}
      end.to change { BxBlockAddProfile::AddProfile.count }
    end
  end

  describe 'Update Add Profile' do
    it 'Update Add Profile' do
      patch :update, params: {id: add_profile.id, token: @token, :full_name => "Prity Soni", :age => 25,  :address => Faker::Address.full_address, :pincode => '460001',
        :city => 'betul', :state => "Madhya Pradesh", :activity_level => 'high'}
      add_profile = JSON.parse(response.body)
      expect(add_profile['data']['attributes']['gender']).to eq 'female'
    end
  end

  describe "DELETE Add Profile" do
    it "should respond with Add Profile" do 
      delete :destroy, params: { id: add_profile.id, token: @token }
      json = JSON.parse(response.body)
      expect(json["success"]).to eq true
    end
  end

end