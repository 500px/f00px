require "faraday_middleware"
require 'typhoeus'
require 'typhoeus/adapters/faraday'

require "f00px/version"
require 'f00px/configuration'
require 'f00px/connection'
require 'f00px/request'
require 'f00px/client'

module F00px

  class << self

    include Configuration

    def client
      @client ||= F00px::Client.new
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end


end
