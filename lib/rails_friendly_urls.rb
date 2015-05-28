require 'singleton'
require 'rails'

#
# Base gem's module
#
# @author Carlos Alonso
#
module RailsFriendlyUrls

  #
  # Method to quickly get the major and minor versions of the current Rails env
  #
  # @returns [String] with X.Y format with major and minor versions
  def self.rails_version
    "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"
  end

end

require 'rails_friendly_urls/manager'
require 'rails_friendly_urls/friendly_url'

case RailsFriendlyUrls.rails_version
when '4.2'
  require 'rails_friendly_urls/route_sets/rails4'
  require 'rails_friendly_urls/urls/rails4_2'
when '4.0', '4.1'
  require 'rails_friendly_urls/route_sets/rails4'
  require 'rails_friendly_urls/urls/rails4_0'
when '3.2'
  require 'rails_friendly_urls/route_sets/rails3'
else
  raise NotImplementedError.new "Rails Friendly URLs gem doesn't support Rails #{Rails.version}"
end
