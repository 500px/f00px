module F00px

  class Client
    include Connection
    include Request
    include Configuration

    def initialize(options = {})

      F00px::Configuration.options.each do |key|
        send "#{key}=".to_sym, options[key] || F00px.send("#{key}".to_sym)
      end

    end


  end
end
