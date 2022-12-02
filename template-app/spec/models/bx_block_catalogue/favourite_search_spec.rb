 require 'rails_helper'

RSpec.describe BxBlockCatalogue::FavouriteSearch, type: :model do
   describe 'Associations' do
      it { should belong_to(:account).optional }
   end

   subject {
      described_class.new(
         product_category: "",
         product_sub_category: "",
         niq_score: "['A']",
         food_allergies: "['Egg']",
         food_preference: "['Veg']",
         functional_preference: "",
         health_preference: "Immunity",
         favourite: true,
         product_count: 1,
         added_count: 1,
         food_type: "['Packaged Food']")
   }

   it "is valid with valid attributes" do
      expect(subject).to be_valid
   end

   it "raises an error if Product Category not valid" do
     subject.product_category = {:"Packaged Food"=>["Cereal based products"]}.to_json
     expect(subject).to be_valid
   end
end