# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'method_call_check/version'

Gem::Specification.new do |spec|
  spec.name          = "method_call_check"
  spec.version       = MethodCallCheck::VERSION
  spec.authors       = ["Jonathan Slate"]
  spec.email         = ["jslate@patientslikeme.com"]

  spec.summary       = %q{Track calls to ruby methods, so you can make sure they aren't being called before you delete them!}
  spec.description   = %q{You can include something like `is_method_called? :some_method` and it will tracked and recorded in Redis.}
  spec.homepage      = "https://github.com/jslate/method_call_check"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
