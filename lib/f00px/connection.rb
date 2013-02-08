module F00px
  module Connection

    def connection
      options = {
        headers: {'Accept' => "application/json"},
        url: "#{endpoint}/#{api_version}"
      }

      Faraday.new(options) do |builder|

        if middleware?
          args = Array(middleware)
          if args.first == ::FaradayMiddleware::OAuth
            tokens = credentials.dup
            tokens.merge!(args.last) if args.length > 1
            builder.use(args.first, tokens)
          else
            builder.use(*middleware)
          end
        end

        builder.request :url_encoded

        builder.response :json, content_type: /\bjson$/

        builder.use Faraday::Response::Logger, logger if logger?

        builder.adapter connection_adapter
      end
    end

    private

    def connection_adapter
      :typhoeus
    end

  end
end
