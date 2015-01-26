
require 'singleton'

module RailsFriendlyUrls

  def self.rails_version
    "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"
  end

end

require 'rails_friendly_urls/manager'
require 'rails_friendly_urls/friendly_url'

case RailsFriendlyUrls.rails_version
when '4.2'
  require 'rails_friendly_urls/route_sets/v1_1'
  require 'rails_friendly_urls/urls/v1_1'
else
  require 'rails_friendly_urls/route_sets/v1_0'
  require 'rails_friendly_urls/urls/v1_0'
end
