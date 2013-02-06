module F00px

  class Runner
    attr_accessor :user_id

    def initialize(conn)
      @queued_requests = []
      @connection = conn
    end

    def get(url, params={})
      request(:get, url, params)
    end

    # Queues a POST request
    def post(url, params={})
      request(:post, url, params)
    end

    def request(method, url, params = {})
      params[:consumer_key] = F00px.consumer_key

      Callback.new(method, versioned_url(url), params).tap do |r|
        @queued_requests << r
      end
    end

    # Runs all queued requests. This method will block until all requests are complete.
    # As requests complete their callbacks will be executed.
    def run!
      conn = @connection

      responses = {}
      conn.in_parallel do
        @queued_requests.each do |callback|
          method, url, params = callback.info

          if user_id
            params ||= {}
            params[:auth_user_id] = user_id
          end

          response = conn.send(method, url, params)
          response.on_complete do
            callback.perform(response)
          end

        end
      end

    ensure
      @queued_requests = []
    end

    private

    def versioned_url(url)
      "/v1#{url}"
    end

  end

end
