require_relative './route_set'
require_relative './url'

module RailsFriendlyUrls
  class Manager
    include Singleton

    def self.inject_urls(mapper)
      self.urls.each do |f_url|
        mapper.get f_url.slug, to: "#{f_url.controller}##{f_url.action}", defaults: f_url.defaults
        mapper.get f_url.path, to: mapper.redirect(f_url.slug)
      end
    end

    def self.apply_changes!
      Rails.application.reload_routes!
    end

    def self.url_for(path)
      self.instance.friendly path
    end

    def friendly(path)
      @all_friendly ||= Hash[*RailsFriendlyUrls::Manager.urls.map { |f_url| [f_url.path, f_url.slug] }.flatten]
      @all_friendly[path] || path
    end
  end
end