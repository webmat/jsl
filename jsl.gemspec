# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jason/version'

Gem::Specification.new do |spec|
  spec.name          = "jason"
  spec.version       = Jason::VERSION
  spec.authors       = ["Mathieu Martin"]
  spec.email         = ["mathieu.martin@lightspeedretail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",  "~> 1.5"
  spec.add_development_dependency "rake",     "~> 10.1.1"
  spec.add_development_dependency "pry-nav",  "~> 0.2.3"
  spec.add_development_dependency "minitest", "~> 5.2.0"

  spec.add_dependency "oj", "~> 2.5.4"
end
