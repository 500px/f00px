module F00px

  class Client
    include Authentication
    include Configuration
    include Connection
    include Request

    include Api::Photos

    def self.configure(&block)
      Client.new.configure(&block)
    end

    def initialize(options = {})
      F00px::Configuration.options.each do |key|
        settings[key] = options[key] || F00px.__send__("#{key}".to_sym)
      end
    end
  end
end
