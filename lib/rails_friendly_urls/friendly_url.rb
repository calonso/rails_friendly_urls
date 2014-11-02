
module RailsFriendlyUrls
  module FriendlyUrl

    def set_destination_data!
      route_info = Rails.application.routes.recognize_path self.path
      self.controller = route_info[:controller]
      self.action = route_info[:action]
      self.defaults = route_info.reject { |k, v| [:controller, :action].include? k }
    end
  end
end