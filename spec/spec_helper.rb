# Configure Rails Environment
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

Bundler.setup

ENV["RAILS_ENV"] = "test"

require 'rails'

case "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"
when '3.2'
  ENV['DATABASE_URL'] = 'sqlite3://localhost/:memory:'
  require 'apps/rails3_2'
when '4.0'
  ENV['DATABASE_URL'] = 'sqlite3://localhost/:memory:'
  require 'apps/rails4'
when '4.1'
  ENV['DATABASE_URL'] = 'sqlite3::memory:'
  require 'apps/rails4'
when '4.2'
  ENV['DATABASE_URL'] = 'sqlite3::memory:'
  require 'apps/rails4'
else
  raise NotImplementedError.new "Rails Friendly URLs gem doesn't support Rails #{Rails.version}"
end

Bundler.require :default
Bundler.require :development

require 'rspec/rails'
require 'rails_friendly_urls'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random
end
