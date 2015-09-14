module F00px
  module Request
    class Runner
      attr_accessor :user_id, :consumer_key

      def initialize(conn)
        @queued_requests = []
        @connection = conn
      end

      def request(method, url, params = {})
        params = params.dup
        params[:consumer_key] = consumer_key

        Callback.new(method, url, params).tap do |r|
          @queued_requests << r
        end
      end

      # Runs all queued requests. This method will block until all requests are complete.
      # As requests complete their callbacks will be executed.
      def run!
        execute_in_parallel do
          @queued_requests.each do |callback|
            execute_request(callback)
          end
        end
      ensure
        @queued_requests = []
      end

      private

      def execute_in_parallel
        if @connection.in_parallel?
          @connection.in_parallel do
            yield
          end
        else
          yield
        end
      end

      def execute_request(callback)
        method, url, params = callback.info
        params ||= {}
        params[:auth_user_id] = user_id if user_id

        response = @connection.run_request(method, url, params, {})

        response.on_complete do
          callback.perform(response)
        end
      end

    end
  end
end
