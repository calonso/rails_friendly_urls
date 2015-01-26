
module ActionDispatch
  module Http
    module URL
      class << self
        def url_for(options = {})
          options = options.dup
          path  = options.delete(:script_name).to_s.chomp("/")
          path << options.delete(:path).to_s

          add_trailing_slash(path) if options[:trailing_slash]

          params = options[:params].is_a?(Hash) ? options[:params] : options.slice(:params)
          params.reject! { |_,v| v.to_param.nil? }

          result = build_host_url(options)

          path = RailsFriendlyUrls::Manager.url_for path

          result << path

          result << "?#{params.to_query}" unless params.empty?
          result << "##{Journey::Router::Utils.escape_fragment(options[:anchor].to_param.to_s)}" if options[:anchor]
          result
        end
      end
    end
  end
end
