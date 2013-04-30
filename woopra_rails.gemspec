# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'woopra_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "woopra_rails"
  spec.version       = WoopraRails::VERSION
  spec.authors       = ["Kevin Hopkins"]
  spec.email         = ["kevin@h-pk-ns.com"]
  spec.description   = %q{Woopra for Ruby on Rails}
  spec.summary       = %q{Server side integration of Woopra HTTP API for Ruby on Rails applications}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
