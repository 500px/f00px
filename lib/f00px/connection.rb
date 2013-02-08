module F00px
  module Connection

    def connection
      options = {
        :headers => {'Accept' => "application/json"},
        :url => endpoint
      }

      Faraday.new(options) do |builder|

        args = Array(auth_middleware)

        if args.first == ::FaradayMiddleware::OAuth
          tokens = credentials.dup
          tokens.merge!(args.last) if args.length > 1
          builder.use(args.first, tokens)
        else
          builder.use(*auth_middleware)
        end

        builder.request :url_encoded

#        builder.response :mashify
        builder.response :json, content_type: /\bjson$/

        builder.use Faraday::Response::Logger, logger if logger?

        builder.adapter connection_adapter
      end
    end

    def connection_adapter
      :typhoeus
    end

  end
end
