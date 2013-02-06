module F00px
  module Connection

    def connection
      options = {
        :headers => {'Accept' => "application/json"},
        :url => F00px.endpoint
      }

      Faraday.new(options) do |builder|
        args = Array.wrap(F00px.auth_middleware)

        if args.first == ::FaradayMiddleware::OAuth

          tokens = F00px.credentials.dup
          tokens.merge!(args.last) if args.lenght > 1
          tokens.merge!(token: token) if token
          tokens.merge!(token_secret: token_secret) if token_secret

          builder.use(args.first, tokens)
        else
          builder.use(*F00px.auth_middleware)
        end

        builder.request :url_encoded

#        builder.response :mashify
        builder.response :json, content_type: /\bjson$/

        builder.use Faraday::Response::Logger, F00px.logger if F00px.logger?

        builder.adapter :typhoeus
      end
    end


  end
end
