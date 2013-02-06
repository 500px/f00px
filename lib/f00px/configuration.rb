module F00px
  module Configuration
    extend self
    extend F00px::Options

    option :endpoint, default: 'https://api.500px.com/'
    option :auth_middleware, default: FaradayMiddleware::OAuth
    option :consumer_key
    option :consumer_secret
    option :token
    option :token_secret
    option :logger

    def configure
      block_given? ? yield(Configuration) : Configuration
    end

    def auth(*options)
      self.auth_middleware = *options
    end

    def credentials
      { :consumer_key => self.consumer_key,
        :consumer_secret => self.consumer_secret,
        :token => self.token,
        :token_secret => self.token_secret
      }
    end

  end
end
