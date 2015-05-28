$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_friendly_urls/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_friendly_urls"
  s.version     = RailsFriendlyUrls::VERSION
  s.authors     = ["Carlos Alonso", "Maria Turnau"]
  s.email       = "info@mrcalonso.com"
  s.homepage    = "http://mrcalonso.com/rails-friendly-urls-gem/"
  s.summary     = "This is a Rails gem that allows to configure friendly urls for any url in your project."
  s.description = "Rails Gem to easily configure any url as a friendlier one."

  s.files = Dir["lib/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.license = 'MIT'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails', '>= 3.2'

  s.add_development_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'generator_spec', '~> 0.9'
end
