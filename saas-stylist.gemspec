# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
controller = File.expand_path('../app/controller', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$LOAD_PATH.unshift(controller) unless $LOAD_PATH.include?(controller)
require 'saas/stylist/version'

Gem::Specification.new do |spec|
  spec.name          = "saas-stylist"
  spec.version       = Saas::Stylist::VERSION
  spec.authors       = ["Finn GmbH"]
  spec.email         = ["info@finn.de"]
  spec.summary       = %q{Useful gem to customise page layout.}
  spec.description   = %q{Useful gem to customise page layout.}
  spec.homepage      = "https://github.com/finnlabs/saas-stylist"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "fuubar"
  spec.add_development_dependency "codeclimate-test-reporter"
end
