require 'spec_helper'

describe F00px::Connection do

  class TestConnection
    include ConfigMock
    include F00px::Connection
  end

  describe ".connection" do

    let(:klass) do
      TestConnection
    end

    it 'returns a faraday connection' do
      klass.new.connection.should be_a(Faraday::Connection)
    end

    context "when getting user from connection", :vcr do

      let(:json) do
        klass.new.connection.get('users').body
      end

      it "returns json" do
        json["user"].should_not be_empty
      end
    end
  end
end
