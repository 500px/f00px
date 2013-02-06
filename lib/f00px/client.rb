module F00px

  class Client
    include Connection
    include Queue

    attr_reader :token, :token_secret, :user_id

    def initialize(options = {})
      @token = options[:token]
      @token_secret = options[:token_secret]
      @user_id = options[:user_id]
    end


    def get(url, params = {})
      queue do |q|
        q.get(url, params).complete do |response|
          return response
        end
      end
    end

    def post
      queue do |q|
        q.post(url, params).complete do |response|
          return response
        end
      end
    end


  end
end
