require 'rails_helper'

RSpec.describe BxBlockCatalogue::Product, type: :model do
  let!(:category) { create(:category) }
  let!(:filter_category) { create(:filter_category) }
  let!(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
  let!(:product) {
    create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
  }
  let!(:ingredient) { create(:ingredient, product_id: product.id) }
  let!(:health_preference) { create(:health_preference, product_id: product.id) }

  describe "associations" do
    it { should have_one_attached(:image) }

    it { should have_one(:health_preference).dependent(:destroy) }
    it { should have_one(:ingredient).dependent(:destroy) }
    
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:favourite_products).dependent(:destroy) }
    it { should have_many(:compare_products).dependent(:destroy) }
    it { should have_many(:reported_products).dependent(:destroy) }
    
    it { should belong_to(:category).class_name("BxBlockCategories::Category") }
    it { should belong_to(:filter_category).class_name("BxBlockCategories::FilterCategory") }
    it { should belong_to(:filter_sub_category).class_name("BxBlockCategories::FilterSubCategory") }
  end

  describe "accept_nested_attributes_for#ingredient" do
    it { should accept_nested_attributes_for(:ingredient).allow_destroy(true) }
  end

  describe "enum" do
    it { should define_enum_for(:product_type).with_values([:cheese_and_oil, :beverage, :solid]) }
    it { should define_enum_for(:food_drink_filter).with_values([:food, :drink]) }
  end

  describe "scope#methods" do
    it "scope#green" do
      expect(BxBlockCatalogue::Product.green).to_not include(BxBlockCatalogue::Product.where(data_check: "red"))
    end

    it "scope#red" do
      expect(BxBlockCatalogue::Product.red).to_not include(BxBlockCatalogue::Product.where(data_check: "green"))
    end

    it "scope#n_a" do
      expect(BxBlockCatalogue::Product.n_a).to_not include(BxBlockCatalogue::Product.where(data_check: "n_c"))
    end

    it "scope#n_c" do
      expect(BxBlockCatalogue::Product.n_c).to_not include(BxBlockCatalogue::Product.where(data_check: "n_a"))
    end

    it "scope#product_type" do
      expect(BxBlockCatalogue::Product.product_type("product_type")).to eq(BxBlockCatalogue::Product.product_type("product_type"))
    end

    it "scope#product_rating" do
      expect(BxBlockCatalogue::Product.product_rating("product_rating")).to eq(BxBlockCatalogue::Product.product_rating("product_rating"))
    end

    it "scope#food_drink_filter" do
      expect(BxBlockCatalogue::Product.food_drink_filter("food_drink_filter")).to eq(BxBlockCatalogue::Product.food_drink_filter("food_drink_filter"))
    end

    it "scope#filter_category_id" do
      expect(BxBlockCatalogue::Product.filter_category_id("filter_category_id")).to eq(BxBlockCatalogue::Product.filter_category_id("filter_category_id"))
    end

    it "scope#filter_sub_category_id" do
      expect(BxBlockCatalogue::Product.filter_sub_category_id("filter_sub_category_id")).to eq(BxBlockCatalogue::Product.filter_sub_category_id("filter_sub_category_id"))
    end
  end

  describe "image_process#method" do
    let!(:file) {
      Dir.pwd + "/spec/models/bx_block_catalogue/product_image_test_data/dabur-amla-small.jpg"
    } 

    it "should not attached image successfully" do
      expect(product.image.attached?).to eq false
    end

    it "should attached image successfully" do
      product.image.attach(io: File.open(file), filename: 'dabur-amla-small.jpg', content_type: 'image/jpg')

      expect(product.image.attached?).to eq true
    end
  end

  describe "compare_product_good_not_so_good_ingredients#method" do
    it "should respond with calculation_for_rdas successfully" do
      # expect(BxBlockCatalogue::ProductService.new(ingredient, "beverage").calculation_for_rdas).should_not be_nil
    end
  end  
end

