module F00px
  module Configuration
    extend self
    include F00px::Options

    option :endpoint, default: 'https://api.500px.com/'
    option :auth_middleware, default: FaradayMiddleware::OAuth
    option :consumer_key
    option :consumer_secret
    option :token
    option :token_secret
    option :logger
    option :user_id

    def self.included(base)
    end

    def configure
      block_given? ? yield(self) : self
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
