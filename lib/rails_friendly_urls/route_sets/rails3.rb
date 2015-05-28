module ActionDispatch
  module Routing
    #
    # Monkey Patched Rails' class ActionDispatch::Routing::RouteSet.
    #
    # @author Carlos Alonso
    #
    class RouteSet
      #
      # Monkey Patched Rails' method: Includes a call to RailsFriendlyUrls::Manager.url_for
      # when the Rails' URL Helper is building a url for a path to use the
      # configured SEO Friendly substutition if any.
      #
      def url_for(options = {})
        finalize!
        options = (options || {}).reverse_merge!(default_url_options)

        handle_positional_args(options)

        user, password = extract_authentication(options)
        path_segments  = options.delete(:_path_segments)
        script_name    = options.delete(:script_name)

        path = (script_name.blank? ? _generate_prefix(options) : script_name.chomp('/')).to_s

        path_options = options.except(*RESERVED_OPTIONS)
        path_options = yield(path_options) if block_given?

        path_addition, params = generate(path_options, path_segments || {})
        path << path_addition
        params.merge!(options[:params] || {})

        path = RailsFriendlyUrls::Manager.url_for path

        ActionDispatch::Http::URL.url_for(options.merge!({
          :path => path,
          :params => params,
          :user => user,
          :password => password
        }))
      end
    end
  end
end

