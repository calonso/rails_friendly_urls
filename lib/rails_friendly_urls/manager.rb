module RailsFriendlyUrls
	module Manager

    def self.included(klass)
      klass.send(:extend, RailsFriendlyUrls::Manager::ClassMethods)
      klass.send(:include, RailsFriendlyUrls::Manager::InstanceMethods)
    end

    module ClassMethods

  		def inject_urls(mapper)
        self.each_url do |f_url|
        	mapper.get f_url.slug, to: "#{f_url.controller}##{f_url.action}", defaults: f_url.defaults
        	mapper.get f_url.path, to: mapper.redirect(f_url.slug)
        end
      end

      def each_url(&block)
        raise MethodNotImplementedError.new "#{self.name} needs to implement each_url method!"
      end

      def apply_changes!
        Rails.application.reload_routes!
      end

    end

    module InstanceMethods

      def set_destination_data!
        route_info = Rails.application.routes.recognize_path self.path
        self.controller = route_info[:controller]
        self.action = route_info[:action]
        self.defaults = route_info.reject { |k, v| [:controller, :action].include? k }
      end

      def set_destination_data
        begin
          set_destination_data!
        rescue ActionController::RoutingError
        end
      end

    end

    class MethodNotImplementedError < NoMethodError

    end

	end
end