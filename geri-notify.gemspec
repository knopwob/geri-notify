# encoding: utf-8

require_relative 'lib/geri-notify/version'

Gem::Specification.new do |spec|
  spec.name          = 'geri-notify'
  spec.version       = GeriNotify::VERSION
  spec.authors       = ['Sascha Kruse']
  spec.email         = ['knopwob@gmail.com']
  spec.summary       = 'Notification Daemon'
  spec.description   = 'something something notifcation something'
  spec.homepage      = 'https://github.com/knopwob/geri-notify'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = ['geri-notify']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'ruby-dbus', '~> 0.11.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  #spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'pry', '0.9.12.6'
end
