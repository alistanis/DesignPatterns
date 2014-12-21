# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
app_models = File.expand_path('../app/models', __FILE__)
$LOAD_PATH.unshift(app_models) unless $LOAD_PATH.include?(app_models)
require 'Patterns/version'

Gem::Specification.new do |spec|
  spec.name          = "Patterns"
  spec.version       = Patterns::VERSION
  spec.authors       = ["Chris Cooper"]
  spec.email         = ["ccooper@sessionm.com"]
  spec.summary       = %q{Design Pattern definitions and implementations in Ruby.}
  spec.description   = %q{This project began because I wanted to help some of the people at work learn Ruby, and I decided I could turn those lessons into a class on design patterns, implementation, and testing.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib app)

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
