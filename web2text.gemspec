require 'rake'
require_relative 'lib/web2text/version'

Gem::Specification.new do |s|
  s.name = 'web2text'
  s.version = Web2Text::VERSION
  s.authors = ["Alex Wilson"]
  s.summary = "Scrape a website as plain text."
  s.homepage = "https://github.com/yourpalal/web2text"
  s.license = "MIT"

  s.executables = ['web2text']
  s.require_paths = ["lib"]

  s.files = FileList['lib/**/*.rb', 'bin/*', 'spec/**/*.rb'].to_a

  s.add_runtime_dependency 'anemone', '~> 0.7'
  s.add_runtime_dependency 'nokogiri', '~> 1.6.6', '>= 1.6.6.2'

  s.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  s.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
  s.add_development_dependency 'test_construct', '~> 2.0'
end
