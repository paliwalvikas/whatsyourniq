  require 'rails_helper'

RSpec.describe AccountBlock::Account, type: :model do
   describe 'Associations' do
    it { should have_many(:favourite_searches).dependent(:destroy)}
    it { should have_many(:favourite_products).dependent(:destroy) }
    it { should have_many(:compare_products)}
    it { should have_many(:orders).dependent(:destroy) }
    # it { should have_many(:add_profiles).dependent(:destroy) }
    it { should have_one(:blacklist_user).dependent(:destroy) }
    it { should have_one_attached(:image) }
  end


  describe "Enum" do
    it { should define_enum_for(:status).with_values([:regular, :suspended, :deleted]) }
    # it { should define_enum_for(:gender).with_values([:female, :male, :other]) }
  end

  it "excludes Account that are  Active" do
    expect(AccountBlock::Account.active).to_not include(AccountBlock::Account.where("status = false"))
  end

  it "it will return existing accounts where status regular" do
    expect(AccountBlock::Account.existing_accounts).to_not include(AccountBlock::Account.where("status = suspended"))
  end 

  it "it will return existing accounts where status suspended" do
    expect(AccountBlock::Account.existing_accounts).to_not include(AccountBlock::Account.where("status = regular"))
  end

  let(:sms_account) { FactoryBot.create(:sms_account) }
  describe 'Callbacks' do
    it 'runs Genrate api key before_save' do
      expect(sms_account.unique_auth_id_previously_changed?).to eq(true)
      sms_account.run_callbacks(:validation)
    end
  end

  describe 'runs set_black_listed_user true ' do 
    it 'runs Set Block listed User after_save' do
      sms_account.update(is_blacklisted: true) do
        sms_account.run_callbacks(:validation)
      end
      sms_account.update(is_blacklisted: false) do 
        sms_account.run_callbacks(:validation)
      end
    end
  end
end

