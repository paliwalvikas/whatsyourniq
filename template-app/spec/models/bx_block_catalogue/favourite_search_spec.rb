 require 'rails_helper'

RSpec.describe BxBlockCatalogue::FavouriteSearch, type: :model do
   describe 'Associations' do
    it { should belong_to(:account) }
  end
end