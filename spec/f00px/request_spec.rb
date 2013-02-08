require 'spec_helper'

describe F00px::Request do

  class TestRequest
    include ::F00px::Request
    include ::F00px::Connection
    include ConfigMock
  end

  let(:klass) { TestRequest }

  let(:instance) { klass.new }

  describe ".get", :vcr do

    let(:json) { instance.get('users/1').body }

    it "responds a json" do
      pending
      json.should be_a(Hash)
    end

    it "responds with a Faraday Response" do
      instance.get('users/1').should be_a(::Faraday::Response)
    end
  end

  describe ".post", :vcr do

    let(:response) do
      instance.post('users', {firstname: 'Arthurn', _method: 'put'})
    end

    it 'returns status 200' do
      response.status.should eq(200)
    end
  end

  describe ".queue", :vcr do

    it "receives a Request::Runner" do

      instance.queue do |q|
        q.should be_a(F00px::Request::Runner)
      end
    end

    context ".get" do

      let(:json) do
        json = nil
        instance.queue do |q|
          q.get('users/1').complete do |r|
            json = r.body
          end
        end
        json
      end

      it "receives a user" do
        json['user'].should_not be_nil
      end
    end

    context ".post" do
      pending
    end
  end
end
