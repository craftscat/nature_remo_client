# frozen_string_literal: true

require_relative 'lib/nature_remo/version'

Gem::Specification.new do |spec|
  spec.name        = 'natureremo'
  spec.version     = NatureRemo::VERSION
  spec.authors     = ['Takumi Yoshida']
  spec.email       = ['umibooose@gmail.com']
  spec.summary     = 'Nature Remo API client for ruby.'
  spec.description = 'Nature Remo API client for ruby.'
  spec.homepage    = 'http://github.com/craftscat/natureremo'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir['lib/**/*', 'LICENCE', 'Rakefile', 'README.md']

  spec.add_dependency 'faraday', '~> 1.0'

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.22'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
