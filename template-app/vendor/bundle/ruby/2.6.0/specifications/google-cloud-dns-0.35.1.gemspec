# -*- encoding: utf-8 -*-
# stub: google-cloud-dns 0.35.1 ruby lib

Gem::Specification.new do |s|
  s.name = "google-cloud-dns".freeze
  s.version = "0.35.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Moore".freeze, "Chris Smith".freeze]
  s.date = "2021-06-17"
  s.description = "google-cloud-dns is the official library for Google Cloud DNS.".freeze
  s.email = ["mike@blowmage.com".freeze, "quartzmo@gmail.com".freeze]
  s.homepage = "https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-dns".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "API Client library for Google Cloud DNS".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<google-cloud-core>.freeze, ["~> 1.6"])
      s.add_runtime_dependency(%q<google-apis-dns_v1>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<googleauth>.freeze, [">= 0.16.2", "< 2.a"])
      s.add_runtime_dependency(%q<zonefile>.freeze, ["~> 1.04"])
      s.add_development_dependency(%q<google-style>.freeze, ["~> 1.25.1"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_development_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_development_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
    else
      s.add_dependency(%q<google-cloud-core>.freeze, ["~> 1.6"])
      s.add_dependency(%q<google-apis-dns_v1>.freeze, ["~> 0.1"])
      s.add_dependency(%q<googleauth>.freeze, [">= 0.16.2", "< 2.a"])
      s.add_dependency(%q<zonefile>.freeze, ["~> 1.04"])
      s.add_dependency(%q<google-style>.freeze, ["~> 1.25.1"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
      s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
      s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
      s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
      s.add_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
      s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
    end
  else
    s.add_dependency(%q<google-cloud-core>.freeze, ["~> 1.6"])
    s.add_dependency(%q<google-apis-dns_v1>.freeze, ["~> 0.1"])
    s.add_dependency(%q<googleauth>.freeze, [">= 0.16.2", "< 2.a"])
    s.add_dependency(%q<zonefile>.freeze, ["~> 1.04"])
    s.add_dependency(%q<google-style>.freeze, ["~> 1.25.1"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14"])
    s.add_dependency(%q<minitest-autotest>.freeze, ["~> 1.0"])
    s.add_dependency(%q<minitest-focus>.freeze, ["~> 1.1"])
    s.add_dependency(%q<minitest-rg>.freeze, ["~> 5.2"])
    s.add_dependency(%q<autotest-suffix>.freeze, ["~> 1.1"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.13"])
  end
end
