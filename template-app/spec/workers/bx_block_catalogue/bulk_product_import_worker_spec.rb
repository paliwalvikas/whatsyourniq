require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.describe BxBlockCatalogue::BulkProductImportWorker, type: :worker do
  describe 'BxBlockCatalogue::BulkProductImportWorker' do
    let(:file_path) {
      Dir.pwd + "/spec/workers/bx_block_catalogue/bulk_product_import_worker_test_csv_data/product_importable_file_format_dup.csv"
    }

    describe '#perform' do
      let!(:perform) {
        subject.perform(file_path)
      }

      it "should perform with file_path" do
        Timecop.freeze(DateTime.now) do
          perform
        end
      end
    end
  end

  let(:time) { (Time.now).to_datetime }
  let(:scheduled_job) { described_class.perform_in(time, 'BxBlockCatalogue::BulkProductImportWorker', true) }

  describe 'testing worker' do
    it { is_expected.to be_retryable false }
    it { is_expected.to be_processed_in "default" }

    it 'BulkProductImportWorker are enqueued in the default queue' do
      described_class.perform_async
      assert_equal "default", described_class.queue
    end

    it "should respond to #perform" do
      expect(BxBlockCatalogue::BulkProductImportWorker.new).to respond_to(:perform)
    end

    context 'occurs' do
      it 'occurs at expected time' do
        scheduled_job
        assert_equal true, described_class.jobs.last['jid'].include?(scheduled_job)
        expect(described_class).to have_enqueued_sidekiq_job('BxBlockCatalogue::BulkProductImportWorker', true)
      end
    end

    context 'when file_path is given' do
      let(:file_path) {
        Dir.pwd + "/spec/workers/bx_block_catalogue/bulk_product_import_worker_test_csv_data/product_importable_file_format_dup.csv"
      }
      
      let(:product_import_status) { BxBlockCatalogue::ImportStatus.create(job_id: "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}") }
      let(:csv_text) {
        open(file_path) do |io|
          io.set_encoding('utf-8')
          io.read
        end
      }
      
      let(:csv) { CSV.parse(csv_text, headers: true) }
      let(:filter_category) { BxBlockCategories::FilterCategory.find_or_create_by(name: "Pasta & Noodles") }
      let(:filter_sub_category) { BxBlockCategories::FilterSubCategory.find_or_create_by(name: "Noodles") }
      let(:product) { BxBlockCatalogue::Product.find_or_initialize_by(bar_code: "bar_code") }
      let(:category) { BxBlockCategories::Category.create(name: "Leong") }
      let(:category_id) { BxBlockCategories::Category.find_or_create_by(id: category.id) }

      before do
        allow(BxBlockCatalogue::ImportStatus).to receive(:create).with(job_id: "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}").and_return(product_import_status)
        allow(CSV).to receive(:parse).with(csv_text: csv_text, headers: true).and_return(csv)
        allow(BxBlockCategories::FilterCategory).to receive(:find_or_create_by).with(name: "Pasta & Noodles").and_return(filter_category)
        allow(BxBlockCategories::FilterSubCategory).to receive(:find_or_create_by).with(name: "Noodles").and_return(filter_sub_category)
        allow(BxBlockCatalogue::Product).to receive(:find_or_initialize_by).with(bar_code: "bar_code").and_return(product)
        allow(BxBlockCategories::Category).to receive(:new).with(category_type: "Packaged Foods").and_return(category_id.id)
      end

      it 'works properly' do
        expect {
          BxBlockCatalogue::BulkProductImportWorker.perform_async(file_path)
        }.to change(described_class.jobs, :size).by(1)
      end
    end

    context 'after product saves' do
      let(:product) { BxBlockCatalogue::Product.find_or_create_by(bar_code: "bar_code") }
      let(:ingredient) { product.build_ingredient(energy: "20.00 kcal", total_sugar: "10 gram") }
      let(:image) { '/home/rails/Pictures/Railway Track Trees Green Way Path 4K Wallpaper-1024x768.jpg' }
      let(:file_url) { URI.parse(image) }
      let(:file) { open(image.strip) }

      ingredient_params = {
        "energy" => "20 kcal",
        "total_sugar" => "10 gram"
      }

      before do
        product.image.attach(
          io: file,
          filename: "my_product_pic",
          content_type: 'csv'
        )
      end

      it 'should save product' do
        expect(product.image).not_to be_nil
        expect(product.image.attached?).to eq true
      end

      before do
        product.build_ingredient(ingredient_params)
        allow(ingredient).to receive(:update).with(ingredient_params).and_return(ingredient)
      end

      it 'should product have ingredient' do
        expect(product.ingredient).not_to be_nil
      end
    end
  end
end
