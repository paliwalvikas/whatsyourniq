# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockCatalogue::ReportedProduct, type: :model do
  describe 'Associations' do
    it { should belong_to(:account) }
    it { should belong_to(:product) }
  end

  describe 'Enum' do
    it { should define_enum_for(:status).with(%i[pending updated]) }
  end
end
