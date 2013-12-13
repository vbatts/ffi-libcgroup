# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'libcgroup/version'

Gem::Specification.new do |spec|
  spec.name          = "libcgroup"
  spec.version       = LibCgroup::VERSION
  spec.authors       = ["Vincent Batts"]
  spec.email         = ["vbatts@redhat.com"]
  spec.description   = %q{bindings for libcgroup}
  spec.summary       = %q{bindings for libcgroup}
  spec.homepage      = "http://github.com/vbatts/ffi-libcgroup/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
