require 'f00px/request/callback'
require 'f00px/request/runner'

module F00px
  module Request

    def queue(&block)
      queue = Request::Runner.new(connection)
      queue.user_id = user_id if user_id?
      queue.consumer_key = consumer_key if consumer_key?
      yield(queue)
      queue.run!
    end

    def get(url, params = {})
      queue do |q|
        q.get(url, params).complete do |response|
          return response
        end
      end
    end

    def post(url, params = {})
      queue do |q|
        q.post(url, params).complete do |response|
          return response
        end
      end
    end

  end
end
