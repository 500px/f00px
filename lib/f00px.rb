# -*- encoding: utf-8 -*-
require "faraday_middleware"
require 'typhoeus'
require 'typhoeus/adapters/faraday'

require "f00px/version"
require 'f00px/options'
require 'f00px/configuration'
require 'f00px/connection'
require 'f00px/callback'
require 'f00px/queue'
require 'f00px/runner'
require 'f00px/client'

module F00px

  class << self

    delegate(*(Configuration.public_instance_methods(false) << { to: Configuration }))

    delegate(:connection, :queue, :get, to: :client)

    def client
      @client ||= F00px::Client.new
    end

  end


end
