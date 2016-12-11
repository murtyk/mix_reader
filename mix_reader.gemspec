# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mix_reader/version'

Gem::Specification.new do |spec|
  spec.name          = "mix_reader"
  spec.version       = MixReader::VERSION
  spec.authors       = ["Murty Korada"]
  spec.email         = ["murtyk@yahoo.com"]

  spec.summary       = %q{API for running JQL on MixPanel to get events and people.}
  spec.homepage      = "https://github.com/murtyk/mix_reader"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.21"
  spec.add_dependency "httparty", "~> 0.13"
end
