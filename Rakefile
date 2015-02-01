require 'bundler'

Bundler.setup
Bundler.require :default

require 'appraisal'
require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RailsFriendlyUrls'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

if !ENV["APPRAISAL_INITIALIZED"] && !ENV["TRAVIS"]
  task default: :appraisal
end
