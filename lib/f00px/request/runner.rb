module F00px
  module Request
    class Runner
      attr_accessor :user_id, :consumer_key

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
        params[:consumer_key] = consumer_key if consumer_key

        Callback.new(method, url, params).tap do |r|
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
            params ||= {}
            params[:auth_user_id] = user_id if user_id

            response = conn.run_request(method, url, params, {})

            response.on_complete do
              callback.perform(response)
            end

          end
        end

      ensure
        @queued_requests = []
      end

    end
  end
end
