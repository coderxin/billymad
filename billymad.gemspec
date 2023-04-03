lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'billymad/version'

Gem::Specification.new do |spec|
  spec.name = 'billymad'
  spec.version = Billymad::VERSION
  spec.authors = ['Andrejs Eisaks']
  spec.email = ['eisaks.andrejs@gmail.com']
  spec.description = 'API wrapper for Billomat'
  spec.summary = 'API wrapper for Billomat'
  spec.homepage = ''
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'webmock'

  spec.add_runtime_dependency 'rest-client'
end
