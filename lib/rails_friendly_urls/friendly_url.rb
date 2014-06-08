
module RailsFriendlyUrls
  module FriendlyUrl

    def set_destination_data
      route_info = Rails.application.routes.recognize_path self.path
      self.controller = route_info[:controller]
      self.action = route_info[:action]
      self.defaults = route_info.reject { |k, v| [:controller, :action].include? k }
    end

    def slug
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement slug method!"
    end

    def path
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement path method!"
    end

    def controller
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement controller method!"
    end

    def action
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement action method!"
    end

    def defaults
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement defaults method!"
    end

    def slug=(slug)
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement slug= method!"
    end

    def path=(path)
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement path=(path) method!"
    end

    def controller=(controller)
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement controller=(controller) method!"
    end

    def action=(action)
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement action=(action) method!"
    end

    def defaults=(defaults)
      raise MethodNotImplementedError.new "#{self.class.name} needs to implement defaults=(defaults) method!"
    end

  end
end