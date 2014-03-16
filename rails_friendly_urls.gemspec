$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_friendly_urls/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_friendly_urls"
  s.version     = RailsFriendlyUrls::VERSION
  s.authors     = ["Carlos Alonso Perez", "Maria Turnau"]
  s.email       = ["carlos@mrcalonso.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsFriendlyUrls."
  s.description = "TODO: Description of RailsFriendlyUrls."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
