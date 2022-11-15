# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do

  let (:social_account) {FactoryBot.create(:social_account)}
  let (:sms_account) {FactoryBot.create(:sms_account)}


  describe "Post 'create' social login" do
    it 'Create Account' do
      expect do
        post :create, params: { data: {type: "social_account", attributes: {email: Faker::Internet.email, unique_auth_id: "fsdfsdwer453tewr4w35"}}}
      end.to change { AccountBlock::SocialAccount.count }
    end

    it 'Check exsisting account'do
      post :create, params: { data: {type: "social_account", attributes: {email: social_account.email}}}
      account = JSON.parse(response.body)
      expect(account['data']['attributes']['email']).to eq 'my_test123@gmail.com'
    end
  end

  describe "Post 'create' sms login" do
    it 'Create Account' do
      expect do
        post :create, params: { data: {type: "sms_account", attributes: {full_phone_number: "919993739000"}}}
      end.to change { AccountBlock::SmsAccount.count }
    end

    it 'Check exsisting account'do
      expect do
        post :create, params: { data: {type: "sms_account", attributes: {full_phone_number: sms_account.full_phone_number}}}
      end.to change { AccountBlock::SmsAccount.count }
    end
  end

  describe 'Update Account' do 
    it 'Update Account' do
      patch :update, params: {id: sms_account.id, data:{attributes: {full_name: "vinay"}}}
      account = JSON.parse(response.body)
      expect(account['data']['attributes']['full_name']).to eq "vinay"
    end
  end

  describe 'Show' do
    it 'its for shoing account' do
      get :show, params: {id: sms_account.id}
      expect(response.message).to eq "OK"
    end
  end

end

