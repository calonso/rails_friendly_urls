
module ActionDispatch
  module Routing
    class RouteSet
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

        path = friendly(path) || path

        ActionDispatch::Http::URL.url_for(options.merge!({
          :path => path,
          :params => params,
          :user => user,
          :password => password
        }))
      end

      def friendly(path)
        @all_friendly ||= Hash[*RailsFriendlyUrls::Manager.urls.map { |f_url| [f_url.path, f_url.slug] }.flatten]
        @all_friendly[path]
      end
      
      def recognize_path(path, environment = {})
        method = (environment[:method] || "GET").to_s.upcase
        path = Journey::Router::Utils.normalize_path(path) unless path =~ %r{://}
        extras = environment[:extras] || {}

        begin
          env = Rack::MockRequest.env_for(path, {:method => method})
        rescue URI::InvalidURIError => e
          raise ActionController::RoutingError, e.message
        end

        req = @request_class.new(env)
        @router.recognize(req) do |route, _matches, params|
          params.merge!(extras)
          params.merge!(req.parameters.symbolize_keys)
          params.each do |key, value|
            if value.is_a?(String)
              value = value.dup.force_encoding(Encoding::BINARY)
              params[key] = URI.parser.unescape(value)
            end
          end
          old_params = env[::ActionDispatch::Routing::RouteSet::PARAMETERS_KEY]
          env[::ActionDispatch::Routing::RouteSet::PARAMETERS_KEY] = (old_params || {}).merge(params)
          dispatcher = route.app
          while dispatcher.is_a?(Mapper::Constraints) && dispatcher.matches?(env) do
            dispatcher = dispatcher.app
          end

          if dispatcher.is_a?(Dispatcher)
            if dispatcher.controller(params, false)
              dispatcher.prepare_params!(params)
              return params
            else
              raise ActionController::RoutingError, "A route matches #{path.inspect}, but references missing controller: #{params[:controller].camelize}Controller"
            end
          elsif dispatcher.is_a?(Redirect)
            return { status: 301, path: dispatcher.block.call({}, nil) }
          end
        end

        raise ActionController::RoutingError, "No route matches #{path.inspect}"
      end
    end
  end
end

