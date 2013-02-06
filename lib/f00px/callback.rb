module F00px
  class Callback

    attr_reader :method, :url, :params

    def initialize(method, url, params={})
      @method, @url, @params = [method, url, params]
    end

    def info
      [method, url, params]
    end

    def perform(response)
      if response.status != 200
        on_error!(response)
      else
        on_success!(response)
      end

      on_complete!(response)
    end

    # Registers an error callback. The callback will be executed if any 400 or 500 HTTP status is returned.
    #
    #  PxApi.get('/photos').
    #   error{|res| puts "HTTP Status: #{res.status}" }
    def error(&block)
      @on_error = block
      self
    end

    # Registers a success callback. This will be triggered if the status code is not 4xx or 5xx.
    def success(&block)
      @on_success = block
      self
    end

    # Register a complete callback. This will be triggered after success or error on all requests.
    def complete(&block)
      @on_complete = block
      self
    end

    private

    def on_error!(response)
      if @on_error.respond_to?(:call)
        @on_error.call response
      end
    end

    def on_success!(response)
      if @on_success.respond_to?(:call)
        @on_success.call response
      end
    end

    def on_complete! response
      if @on_complete.respond_to?(:call)
        @on_complete.call response
      end
    end
  end
end
