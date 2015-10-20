# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplemdm/version'

Gem::Specification.new do |spec|
  spec.name          = "simplemdm"
  spec.version       = SimpleMDM::VERSION
  spec.authors       = ["Taylor Boyko"]
  spec.email         = ["taylor@wrprojects.com"]

  spec.summary       = %q{Ruby bindings for the SimpleMDM API.}
  spec.homepage      = "http://www.simplemdm.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "rest-client", "~> 1.8"
end
