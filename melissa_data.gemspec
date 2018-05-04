# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'melissa_data/version'

Gem::Specification.new do |spec|
  spec.name          = "melissa_data"
  spec.version       = MelissaData::VERSION
  spec.authors       = ["Robert Grayson", "Jonah Ruiz"]
  spec.email         = ["bobbygrayson@gmail.com", "jonah@pixelhipsters.com"]

  spec.summary       = %q{A simple interface to Melissa Data's Web Smart Property API}
  spec.description   = %q{A simple interface to Melissa Data's Web Smart Property API}
  spec.homepage      = "https://github.com/accessterminal/melissa_data"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.3'

  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "geokit"
  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
