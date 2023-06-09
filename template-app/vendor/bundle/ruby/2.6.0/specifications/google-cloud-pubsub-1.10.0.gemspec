# -*- encoding: utf-8 -*-
# stub: google-cloud-pubsub 1.10.0 ruby lib

Gem::Specification.new do |s|
  s.name = "google-cloud-pubsub".freeze
  s.version = "1.10.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Moore".freeze, "Chris Smith".freeze]
  s.date = "2020-07-23"
  s.description = "google-cloud-pubsub is the official library for Google Cloud Pub/Sub.".freeze
  s.email = ["mike@blowmage.com".freeze, "quartzmo@gmail.com".freeze]
  s.homepage = "https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-pubsub".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "API Client library for Google Cloud Pub/Sub".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1"])
      s.add_runtime_dependency(%q<google-cloud-core>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<google-gax>.freeze, ["~> 1.8"])
      s.add_runtime_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.9", "< 2.0"])
      s.add_runtime_dependency(%q<googleapis-common-protos-types>.freeze, [">= 1.0.4", "< 2.0"])
      s.add_runtime_dependency(%q<grpc-google-iam-v1>.freeze, ["~> 0.6.9"])
      s.add_development_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_development_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
    else
      s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1"])
      s.add_dependency(%q<google-cloud-core>.freeze, ["~> 1.2"])
      s.add_dependency(%q<google-gax>.freeze, ["~> 1.8"])
      s.add_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.9", "< 2.0"])
      s.add_dependency(%q<googleapis-common-protos-types>.freeze, [">= 1.0.4", "< 2.0"])
      s.add_dependency(%q<grpc-google-iam-v1>.freeze, ["~> 0.6.9"])
      s.add_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
      s.add_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
      s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
    end
  else
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1"])
    s.add_dependency(%q<google-cloud-core>.freeze, ["~> 1.2"])
    s.add_dependency(%q<google-gax>.freeze, ["~> 1.8"])
    s.add_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.9", "< 2.0"])
    s.add_dependency(%q<googleapis-common-protos-types>.freeze, [">= 1.0.4", "< 2.0"])
    s.add_dependency(%q<grpc-google-iam-v1>.freeze, ["~> 0.6.9"])
    s.add_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
    s.add_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
    s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
  end
end
