FactoryGirl.define do
  factory :import_status, class: BxBlockCatalogue::ImportStatus do
    job_id "Job: #{Time.now.strftime('%Y%m%d%H%M%S')}"
  end
end
