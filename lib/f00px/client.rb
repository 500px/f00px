module F00px

  class Client
    include Connection
    include Queue

    include Configuration

    def initialize(options = {})

      F00px::Configuration.defaults.keys.each do |key|
        send "#{key}=".to_sym, options[key] || F00px.send("#{key}".to_sym)
      end

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
