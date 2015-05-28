module ActionDispatch
  module Routing
    #
    # Monkey Patched Rails' class ActionDispatch::Routing::RouteSet.
    #
    # @author Carlos Alonso
    #
    class RouteSet
      #
      # Monkey Patched Rails' method to recognize redirections as well as, for some
      # reason, the original Rails' method doesn't.
      #
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
          params = _matches if params.nil?
          params.merge!(extras)
          params.merge!(req.parameters.symbolize_keys)
          params.each do |key, value|
            if value.is_a?(String)
              value = value.dup.force_encoding(Encoding::BINARY)
              params[key] = URI.parser.unescape(value)
            end
          end

          old_params = env[params_key]
          env[params_key] = (old_params || {}).merge(params)
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
          elsif dispatcher.is_a?(redirect_class)
            return { status: 301, path: path_from_dispatcher(dispatcher) }
          end
        end

        raise ActionController::RoutingError, "No route matches #{path.inspect}"
      end

      private

      #
      # INTERNAL: Helps deciding which module take the PARAMETERS_KEY constant
      # from. This constant was moved in Rails 4.2 from one to another and
      # using this method here allows us to reuse this file for all Rails 4.x
      #
      def params_key
        defined?(::ActionDispatch::Http::Parameters::PARAMETERS_KEY) ?
          ::ActionDispatch::Http::Parameters::PARAMETERS_KEY :
            ::ActionDispatch::Routing::RouteSet::PARAMETERS_KEY
      end

      #
      # INTERNAL: Helps reusing code by deciding which class to consider
      # as the redirection depending on the Rails version running.
      #
      # @returns [ActionDispatch::Routing::Redirect] or [ActionDispatch::Routing::PathRedirect]
      def redirect_class
        Rails::VERSION::MAJOR == 3 ? Redirect : PathRedirect
      end

      #
      # INTERNAL: Helps reusing code by obtaining the path from the Rails'
      # ActionDispatch::Routing::Dispatcher depending on the Rails version
      # running.
      #
      # @param [ActionDispatch::Routing::Dispatcher] in use.
      # @return [String] the destination path of the redirection.
      def path_from_dispatcher(dispatcher)
        if Rails::VERSION::MAJOR == 3
          dispatcher.block.call({}, nil)
        else
          dispatcher.block
        end
      end
    end
  end
end

