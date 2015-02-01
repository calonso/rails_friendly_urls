
require 'singleton'
require 'rails'

module RailsFriendlyUrls

  def self.rails_version
    "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"
  end

end

require 'rails_friendly_urls/manager'
require 'rails_friendly_urls/friendly_url'

case RailsFriendlyUrls.rails_version
when '4.2'
  require 'rails_friendly_urls/route_sets/rails4_2'
  require 'rails_friendly_urls/urls/rails4_2'
when '4.1'
  require 'rails_friendly_urls/route_sets/rails4_0'
  require 'rails_friendly_urls/urls/rails4_0'
when '4.0'
  require 'rails_friendly_urls/route_sets/rails4_0'
  require 'rails_friendly_urls/urls/rails4_0'
else
  require 'rails_friendly_urls/route_sets/rails3'
end
