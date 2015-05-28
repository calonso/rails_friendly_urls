module ActionDispatch
  module Http
    #
    # Monkey Patched Rails' module ActionDispatch::Http::URL
    #
    # @author Carlos Alonso
    #
    module URL
      #
      # Monkey Patched Rails' method: Includes a call to RailsFriendlyUrls::Manager.url_for
      # when the Rails' URL Helper is building a url for a path to use the
      # configured SEO Friendly substutition if any.
      #
      def self.path_for(options)
        path  = options[:script_name].to_s.chomp("/")
        path << options[:path] if options.key?(:path)

        add_trailing_slash(path) if options[:trailing_slash]
        add_params(path, options[:params]) if options.key?(:params)
        add_anchor(path, options[:anchor]) if options.key?(:anchor)

        RailsFriendlyUrls::Manager.url_for path
      end
    end
  end
end
