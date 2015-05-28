module RailsFriendlyUrls
  #
  # This class is responsible for orchestrating the whole gem's functions.
  #
  # @author Carlos Alonso
  #
  class Manager
    # It is designed to be a Singleton, only one instance will run per process.
    include Singleton

    #
    # Injects the defined urls into the given RouteSet. This method should be invoked
    # first thing in the routes.rb block
    #
    # @param [ActionDispatch::Routing::RouteSet] rails' current RouteSet.
    def self.inject_urls(mapper)
      list = self.urls || []
      Rails.logger.warn "Injecting empty Friendly URLs List!!" if list.empty?
      list.each do |f_url|
        mapper.get f_url.slug, to: "#{f_url.controller}##{f_url.action}", defaults: f_url.defaults
        mapper.get f_url.path, to: mapper.redirect(f_url.slug)
      end
    end

    #
    # Invokes Rails' routes reload. Useful to reload the routes after
    # modifying the list of SEO Friendly defined ones without having to
    # restart the application server.
    #
    def self.apply_changes!
      Rails.application.reload_routes!
    end

    #
    # This method is used in Rails' URL Helpers to return the corresponding
    # SEO Friendly URL instead of the default one.
    #
    # @param [String] The path we want the URL for.
    # @returns [String] The SEO Friendly Slug for the required path.
    def self.url_for(path)
      self.instance.friendly path
    end

    #
    # INTERNAL: Searches the list of SEO Friendly defined substitutions for
    # the corresponding to the given path
    #
    # @param [String] The path we want the substitution for.
    # @returns [String] The SEO Friendly Slugh for the required path.
    def friendly(path)
      @all_friendly ||= Hash[*RailsFriendlyUrls::Manager.urls.map { |f_url| [f_url.path, f_url.slug] }.flatten]
      @all_friendly[path] || path
    end
  end
end
