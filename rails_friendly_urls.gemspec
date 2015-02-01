$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_friendly_urls/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_friendly_urls"
  s.version     = RailsFriendlyUrls::VERSION
  s.authors     = ["Carlos Alonso", "Maria Turnau"]
  s.email       = "carlos@mrcalonso.com"
  s.homepage    = "http://mrcalonso.com/rails-friendly-urls-gem/"
  s.summary     = "Summary of RailsFriendlyUrls."
  s.description = "Description of RailsFriendlyUrls."

  s.files = Dir["lib/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'rails'

  s.add_development_dependency 'appraisal'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-core', '~> 2.4'
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'generator_spec'
  s.add_development_dependency 'byebug'
end
