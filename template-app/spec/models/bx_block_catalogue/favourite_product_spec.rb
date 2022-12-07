# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::FavouriteProduct, type: :model do
  describe 'Associations' do
    it { should belong_to(:account) }
    it { should belong_to(:product) }
  end

  describe 'Validations' do
  	it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:account_id) }
  end

end
