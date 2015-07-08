# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'query_params/version'

Gem::Specification.new do |spec|
  spec.name          = "query_params"
  spec.version       = QueryParams::VERSION
  spec.authors       = ["William Souza"]
  spec.email         = ["willmiranda@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.summary       = %q{Format URL parameters like a query.}
  spec.description   = %q{It allows you to send operators and the same parameter twice on the same request.}
  spec.homepage      = "https://github.com/willmiranda/query-params"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
