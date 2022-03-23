# -*- encoding: utf-8 -*-
# stub: grpc-google-iam-v1 0.6.11 ruby lib

Gem::Specification.new do |s|
  s.name = "grpc-google-iam-v1".freeze
  s.version = "0.6.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Google Inc".freeze]
  s.date = "2021-02-01"
  s.email = ["googleapis-packages@google.com".freeze]
  s.homepage = "https://github.com/googleapis/common-protos-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Common protos and gRPC services for Google IAM".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.11", "< 2.0"])
      s.add_runtime_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
      s.add_runtime_dependency(%q<grpc>.freeze, ["~> 1.27"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<grpc-tools>.freeze, ["~> 1.27"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    else
      s.add_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.11", "< 2.0"])
      s.add_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
      s.add_dependency(%q<grpc>.freeze, ["~> 1.27"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.1"])
      s.add_dependency(%q<grpc-tools>.freeze, ["~> 1.27"])
      s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    end
  else
    s.add_dependency(%q<googleapis-common-protos>.freeze, [">= 1.3.11", "< 2.0"])
    s.add_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
    s.add_dependency(%q<grpc>.freeze, ["~> 1.27"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.1"])
    s.add_dependency(%q<grpc-tools>.freeze, ["~> 1.27"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
  end
end
