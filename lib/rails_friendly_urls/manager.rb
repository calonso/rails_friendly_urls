require_relative './route_set'

module RailsFriendlyUrls
  class Manager

    def self.inject_urls(mapper)
      self.each_url do |f_url|
        mapper.get f_url.slug, to: "#{f_url.controller}##{f_url.action}", defaults: f_url.defaults
        mapper.get f_url.path, to: mapper.redirect(f_url.slug)
      end
    end

    def self.each_url(&block)
      raise MethodNotImplementedError.new "#{self.name} needs to implement each_url method!"
    end

    def self.apply_changes!
      Rails.application.reload_routes!
    end

  end

  class MethodNotImplementedError < NoMethodError

  end
end