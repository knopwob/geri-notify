# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gerri-notify/version'

Gem::Specification.new do |spec|
  spec.name          = 'gerri-notify'
  spec.version       = GerriNotify::VERSION
  spec.authors       = ['Sascha Kruse']
  spec.email         = ['knopwob@gmail.com']
  spec.summary       = 'Notification Daemon'
  spec.description   = 'something something notifcation something'
  spec.homepage      = 'https://github.com/knopwob/gerri-notify'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = ['gerri-notify']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'ruby-dbus', '~> 0.11.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  #spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'pry', '0.9.12.6'
end

