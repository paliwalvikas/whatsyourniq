require 'rails_helper'
require 'sidekiq/testing'

Sidekiq::Testing.fake!

RSpec.describe BxBlockCatalogue::ProductCalculationWorker, type: :worker do
  let(:time) { (Time.now).to_datetime }
  let(:scheduled_job) { described_class.perform_in(time, 'BxBlockCatalogue::ProductCalculationWorker', true) }

  describe 'testing worker' do
    it { is_expected.to be_retryable 3 }

    it 'ProductCalculationWorker are enqueued in the default queue' do
      described_class.perform_async
      assert_equal "default", described_class.queue
    end
    
    it 'goes into the jobs array for testing environment with calculation_types calculate_np' do
      expect do
        described_class.perform_async("calculate_np")
      end.to change(described_class.jobs, :size).by(1)
      
      described_class.new.perform("calculate_np")
    end

    it 'goes into the jobs array for testing environment with calculation_types calculate_ratings' do
      expect do
        described_class.perform_async("calculate_ratings")
      end.to change(described_class.jobs, :size).by(1)
      
      described_class.new.perform("calculate_ratings")
    end

    it { is_expected.to be_processed_in "default" }

    context 'occurs daily' do
      it 'occurs at expected time' do
        scheduled_job
        assert_equal true, described_class.jobs.last['jid'].include?(scheduled_job)
        expect(described_class).to have_enqueued_sidekiq_job('BxBlockCatalogue::ProductCalculationWorker', true)
      end
    end

    it "should respond to #perform" do
      expect(BxBlockCatalogue::ProductCalculationWorker.new).to respond_to(:perform)
    end
  end
end
