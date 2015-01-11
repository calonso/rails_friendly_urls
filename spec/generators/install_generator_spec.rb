
require 'generators/rails_friendly_urls/install_generator'

describe RailsFriendlyUrls::InstallGenerator, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)

  before do
    prepare_destination
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

end