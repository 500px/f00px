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

        builder.use Faraday::Response::Logger, logger if logger?

        builder.adapter *faraday_adapter
      end
    end

  end
end
