
require 'generators/rails_friendly_urls/install_generator'

describe RailsFriendlyUrls::InstallGenerator, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)

  before do
    prepare_destination
    mkdir File.join(destination_root, 'config')
    cp 'spec/support/dummy_routes.rb', File.join(destination_root, 'config/routes.rb')
    run_generator
  end

  after do
    rm_rf destination_root
  end

  it 'creates the Rails Friendly Urls Manager' do
    assert_file "config/initializers/friendly_urls_manager.rb", <<-EOS 
# FriendlyUrls Manager contents
class RailsFriendlyUrls::Manager 
  def self.urls
    raise NotImplementedError.new 'RailsFriendlyUrls::Manager::urls not implemented at config/initializers/friendly_urls_manager.rb'
  end
end
    EOS
  end

  it 'injects the Rails Friendly Urls in routes' do
    assert_file "config/routes.rb", <<-EOS 
Dummy::Application.routes.draw do

  RailsFriendlyUrls::Manager.inject_urls self
end
    EOS
  end

end