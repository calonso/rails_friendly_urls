module RailsFriendlyUrls
  #
  # This module is to be included in the client class that represents the Friendly URL
  #
  # @author Carlos Alonso
  #
  module FriendlyUrl
    #
    # This method tries to identify the route contained at self.path to extract
    # the destination's controller, action and other arguments and save them
    # into the corresponding controller, action and defaults fields of the
    # including objects.
    #
    def set_destination_data!
      route_info = Rails.application.routes.recognize_path self.path
      self.controller = route_info[:controller]
      self.action = route_info[:action]
      self.defaults = route_info.reject { |k, v| [:controller, :action].include? k }
    end
  end
end
