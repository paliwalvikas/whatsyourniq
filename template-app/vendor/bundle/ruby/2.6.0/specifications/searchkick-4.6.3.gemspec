# -*- encoding: utf-8 -*-
# stub: searchkick 4.6.3 ruby lib

Gem::Specification.new do |s|
  s.name = "searchkick".freeze
  s.version = "4.6.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrew Kane".freeze]
  s.date = "2021-11-19"
  s.email = "andrew@ankane.org".freeze
  s.homepage = "https://github.com/ankane/searchkick".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Intelligent search made easy with Rails and Elasticsearch or OpenSearch".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 5"])
      s.add_runtime_dependency(%q<elasticsearch>.freeze, [">= 6", "< 7.14"])
      s.add_runtime_dependency(%q<hashie>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activemodel>.freeze, [">= 5"])
      s.add_dependency(%q<elasticsearch>.freeze, [">= 6", "< 7.14"])
      s.add_dependency(%q<hashie>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>.freeze, [">= 5"])
    s.add_dependency(%q<elasticsearch>.freeze, [">= 6", "< 7.14"])
    s.add_dependency(%q<hashie>.freeze, [">= 0"])
  end
end
