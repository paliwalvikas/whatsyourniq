# -*- encoding: utf-8 -*-
# stub: google-cloud-tasks 1.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "google-cloud-tasks".freeze
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Google LLC".freeze]
  s.date = "2020-04-01"
  s.description = "google-cloud-tasks is the official library for Cloud Tasks API.".freeze
  s.email = "googleapis-packages@google.com".freeze
  s.homepage = "https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-tasks".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "API Client library for Cloud Tasks API".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<google-gax>.freeze, ["~> 1.8"])
      s.add_runtime_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.9", "< 2.0"])
      s.add_runtime_dependency(%q<googleapis-common-protos-types>.freeze, [">= 1.0.4", "< 2.0"])
      s.add_runtime_dependency(%q<grpc-google-iam-v1>.freeze, ["~> 0.6.9"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.10"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
    else
      s.add_dependency(%q<google-gax>.freeze, ["~> 1.8"])
      s.add_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.9", "< 2.0"])
      s.add_dependency(%q<googleapis-common-protos-types>.freeze, [">= 1.0.4", "< 2.0"])
      s.add_dependency(%q<grpc-google-iam-v1>.freeze, ["~> 0.6.9"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.10"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<google-gax>.freeze, ["~> 1.8"])
    s.add_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.9", "< 2.0"])
    s.add_dependency(%q<googleapis-common-protos-types>.freeze, [">= 1.0.4", "< 2.0"])
    s.add_dependency(%q<grpc-google-iam-v1>.freeze, ["~> 0.6.9"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.10"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
    s.add_dependency(%q<google-style>.freeze, ["~> 1.24.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
  end
end
