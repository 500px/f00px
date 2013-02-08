require 'spec_helper'

describe F00px::Connection do

  class TestConnection
    include F00px::Connection

    def endpoint
      'https://api.500px.com'
    end

    def auth_middleware
      ::VCR::Middleware::Faraday
    end

    def logger?
      false
    end

    def credentials
      {}
    end
  end

  describe ".connection" do

    let(:klass) do
      TestConnection
    end

    it 'returns a faraday connection' do
      klass.new.connection.should be_a(Faraday::Connection)
    end

    context "when getting user from connection" do

      let(:json) do
        JSON.parse(klass.new.connection.get('/v1/users').body)
      end

      it "returns json" do
        VCR.use_cassette('users') do
          json["user"].should_not be_empty
        end
      end
    end
  end
end
