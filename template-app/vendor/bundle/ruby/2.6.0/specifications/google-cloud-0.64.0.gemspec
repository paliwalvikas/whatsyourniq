# -*- encoding: utf-8 -*-
# stub: google-cloud 0.64.0 ruby lib

Gem::Specification.new do |s|
  s.name = "google-cloud".freeze
  s.version = "0.64.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Moore".freeze, "Chris Smith".freeze]
  s.date = "2019-12-20"
  s.description = "google-cloud is the official library for Google Cloud Platform APIs.".freeze
  s.email = ["mike@blowmage.com".freeze, "quartzmo@gmail.com".freeze]
  s.homepage = "https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.post_install_message = "------------------------------\nThank you for installing Google Cloud!\n\nIMPORTANT NOTICE:\nThe google-cloud gem contains all the google-cloud-* gems.\nInstead of depending on this gem, we encourage you to install just\nthe individual gems needed for your project.\n------------------------------\n".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "API Client library for Google Cloud".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<google-cloud-asset>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-bigquery>.freeze, ["~> 1.1"])
      s.add_runtime_dependency(%q<google-cloud-bigquery-data_transfer>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-bigtable>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<google-cloud-container>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-dataproc>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-datastore>.freeze, ["~> 1.4"])
      s.add_runtime_dependency(%q<google-cloud-dialogflow>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-dlp>.freeze, ["~> 0.4"])
      s.add_runtime_dependency(%q<google-cloud-dns>.freeze, ["~> 0.28"])
      s.add_runtime_dependency(%q<google-cloud-error_reporting>.freeze, ["~> 0.30"])
      s.add_runtime_dependency(%q<google-cloud-firestore>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<google-cloud-kms>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<google-cloud-language>.freeze, ["~> 0.30"])
      s.add_runtime_dependency(%q<google-cloud-logging>.freeze, ["~> 1.5"])
      s.add_runtime_dependency(%q<google-cloud-monitoring>.freeze, ["~> 0.28"])
      s.add_runtime_dependency(%q<google-cloud-os_login>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-phishing_protection>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-pubsub>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<google-cloud-recaptcha_enterprise>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-redis>.freeze, ["~> 0.2"])
      s.add_runtime_dependency(%q<google-cloud-resource_manager>.freeze, ["~> 0.29"])
      s.add_runtime_dependency(%q<google-cloud-scheduler>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<google-cloud-security_center>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-spanner>.freeze, ["~> 1.3"])
      s.add_runtime_dependency(%q<google-cloud-speech>.freeze, ["~> 0.29"])
      s.add_runtime_dependency(%q<google-cloud-storage>.freeze, ["~> 1.10"])
      s.add_runtime_dependency(%q<google-cloud-talent>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-tasks>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<google-cloud-text_to_speech>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<google-cloud-trace>.freeze, ["~> 0.31"])
      s.add_runtime_dependency(%q<google-cloud-translate>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<google-cloud-video_intelligence>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<google-cloud-vision>.freeze, ["~> 0.28"])
      s.add_development_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.10"])
      s.add_development_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
    else
      s.add_dependency(%q<google-cloud-asset>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-bigquery>.freeze, ["~> 1.1"])
      s.add_dependency(%q<google-cloud-bigquery-data_transfer>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-bigtable>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-cloud-container>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-dataproc>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-datastore>.freeze, ["~> 1.4"])
      s.add_dependency(%q<google-cloud-dialogflow>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-dlp>.freeze, ["~> 0.4"])
      s.add_dependency(%q<google-cloud-dns>.freeze, ["~> 0.28"])
      s.add_dependency(%q<google-cloud-error_reporting>.freeze, ["~> 0.30"])
      s.add_dependency(%q<google-cloud-firestore>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-cloud-kms>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-cloud-language>.freeze, ["~> 0.30"])
      s.add_dependency(%q<google-cloud-logging>.freeze, ["~> 1.5"])
      s.add_dependency(%q<google-cloud-monitoring>.freeze, ["~> 0.28"])
      s.add_dependency(%q<google-cloud-os_login>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-phishing_protection>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-pubsub>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-cloud-recaptcha_enterprise>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-redis>.freeze, ["~> 0.2"])
      s.add_dependency(%q<google-cloud-resource_manager>.freeze, ["~> 0.29"])
      s.add_dependency(%q<google-cloud-scheduler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-cloud-security_center>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-spanner>.freeze, ["~> 1.3"])
      s.add_dependency(%q<google-cloud-speech>.freeze, ["~> 0.29"])
      s.add_dependency(%q<google-cloud-storage>.freeze, ["~> 1.10"])
      s.add_dependency(%q<google-cloud-talent>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-tasks>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-cloud-text_to_speech>.freeze, ["~> 0.1"])
      s.add_dependency(%q<google-cloud-trace>.freeze, ["~> 0.31"])
      s.add_dependency(%q<google-cloud-translate>.freeze, ["~> 2.0"])
      s.add_dependency(%q<google-cloud-video_intelligence>.freeze, ["~> 2.0"])
      s.add_dependency(%q<google-cloud-vision>.freeze, ["~> 0.28"])
      s.add_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
      s.add_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.10"])
      s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
      s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
    end
  else
    s.add_dependency(%q<google-cloud-asset>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-bigquery>.freeze, ["~> 1.1"])
    s.add_dependency(%q<google-cloud-bigquery-data_transfer>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-bigtable>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-cloud-container>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-dataproc>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-datastore>.freeze, ["~> 1.4"])
    s.add_dependency(%q<google-cloud-dialogflow>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-dlp>.freeze, ["~> 0.4"])
    s.add_dependency(%q<google-cloud-dns>.freeze, ["~> 0.28"])
    s.add_dependency(%q<google-cloud-error_reporting>.freeze, ["~> 0.30"])
    s.add_dependency(%q<google-cloud-firestore>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-cloud-kms>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-cloud-language>.freeze, ["~> 0.30"])
    s.add_dependency(%q<google-cloud-logging>.freeze, ["~> 1.5"])
    s.add_dependency(%q<google-cloud-monitoring>.freeze, ["~> 0.28"])
    s.add_dependency(%q<google-cloud-os_login>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-phishing_protection>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-pubsub>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-cloud-recaptcha_enterprise>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-redis>.freeze, ["~> 0.2"])
    s.add_dependency(%q<google-cloud-resource_manager>.freeze, ["~> 0.29"])
    s.add_dependency(%q<google-cloud-scheduler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-cloud-security_center>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-spanner>.freeze, ["~> 1.3"])
    s.add_dependency(%q<google-cloud-speech>.freeze, ["~> 0.29"])
    s.add_dependency(%q<google-cloud-storage>.freeze, ["~> 1.10"])
    s.add_dependency(%q<google-cloud-talent>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-tasks>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-cloud-text_to_speech>.freeze, ["~> 0.1"])
    s.add_dependency(%q<google-cloud-trace>.freeze, ["~> 0.31"])
    s.add_dependency(%q<google-cloud-translate>.freeze, ["~> 2.0"])
    s.add_dependency(%q<google-cloud-video_intelligence>.freeze, ["~> 2.0"])
    s.add_dependency(%q<google-cloud-vision>.freeze, ["~> 0.28"])
    s.add_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
    s.add_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.10"])
    s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
  end
end
