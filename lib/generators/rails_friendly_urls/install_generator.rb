
class RailsFriendlyUrls::InstallGenerator < Rails::Generators::Base
  desc 'Creates a boilerplate Friendly Urls Manager with an empty implementation for you to complete.'
  def create_friendly_urls_manager
    create_file "config/initializers/friendly_urls_manager.rb", <<-EOS 
# FriendlyUrls Manager contents
class RailsFriendlyUrls::Manager 
  def self.urls
    raise NotImplementedError.new 'RailsFriendlyUrls::Manager::urls not implemented at config/initializers/friendly_urls_manager.rb'
  end
end
    EOS
  end

end
