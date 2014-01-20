# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivotal/version'

Gem::Specification.new do |spec|
  spec.name          = "pivotal"
  spec.version       = Pivotal::VERSION
  spec.authors       = ["Chris Ledet"]
  spec.email         = ["chris.ledet@wildbit.com"]
  spec.description   = "Yet another lightweight Pivotal Tracker API client for Ruby"
  spec.summary       = "Yet another lightweight Pivotal Tracker API client for Ruby"
  spec.homepage      = "https://beanstalkapp.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'turn'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'multi_json'
end
