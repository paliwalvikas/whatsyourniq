# -*- encoding: utf-8 -*-
# stub: zonefile 1.06 ruby lib

Gem::Specification.new do |s|
  s.name = "zonefile".freeze
  s.version = "1.06"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Martin Boese".freeze]
  s.date = "2017-06-15"
  s.description = "A library that can create, read, write, modify BIND compatible Zonefiles (RFC1035).\nWarning: It probably works for most cases, but it might not be able to read all files \neven if they are valid for bind.".freeze
  s.email = "martin@internet.ao".freeze
  s.homepage = "http://zonefile.rubyforge.org/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "BIND 8/9 Zonefile Reader and Writer".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version
end
