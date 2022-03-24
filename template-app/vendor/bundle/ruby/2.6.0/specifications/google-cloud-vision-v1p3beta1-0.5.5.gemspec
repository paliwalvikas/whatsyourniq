# -*- encoding: utf-8 -*-
# stub: google-cloud-vision-v1p3beta1 0.5.5 ruby lib

Gem::Specification.new do |s|
  s.name = "google-cloud-vision-v1p3beta1".freeze
  s.version = "0.5.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Google LLC".freeze]
  s.date = "2022-01-11"
  s.description = "Cloud Vision API allows developers to easily integrate vision detection features within applications, including image labeling, face and landmark detection, optical character recognition (OCR), and tagging of explicit content. Note that google-cloud-vision-v1p3beta1 is a version-specific client library. For most uses, we recommend installing the main client library google-cloud-vision instead. See the readme for more details.".freeze
  s.email = "googleapis-packages@google.com".freeze
  s.homepage = "https://github.com/googleapis/google-cloud-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "API Client library for the Cloud Vision V1p3beta1 API".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gapic-common>.freeze, [">= 0.7", "< 2.a"])
      s.add_runtime_dependency(%q<google-cloud-errors>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<google-style>.freeze, ["~> 1.25.1"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_development_dependency(%q<rake>.freeze, [">= 12.0"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.18"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
    else
      s.add_dependency(%q<gapic-common>.freeze, [">= 0.7", "< 2.a"])
      s.add_dependency(%q<google-cloud-errors>.freeze, ["~> 1.0"])
      s.add_dependency(%q<google-style>.freeze, ["~> 1.25.1"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_dependency(%q<rake>.freeze, [">= 12.0"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.18"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<gapic-common>.freeze, [">= 0.7", "< 2.a"])
    s.add_dependency(%q<google-cloud-errors>.freeze, ["~> 1.0"])
    s.add_dependency(%q<google-style>.freeze, ["~> 1.25.1"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
    s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
    s.add_dependency(%q<rake>.freeze, [">= 12.0"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.18"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
  end
end
