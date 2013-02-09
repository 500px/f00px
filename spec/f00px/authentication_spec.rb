require 'spec_helper'

describe F00px::Authentication do

  let(:client) do
    F00px::Client.configure do |c|
    end
  end

  describe ".xauth" do

    context "when passing valid credentials" do

      let(:response) do
        mock(Faraday::Response, status: 200, body:'oauth_token=a&oauth_token_secret=b')
      end

      let(:username) { 'user' }

      let(:password) { 'abc123=1' }

      let(:params) do
        { x_auth_mode: "client_auth", x_auth_username: username, x_auth_password: password}
      end

      before do
        client.should_receive(:post).with('oauth/request_token').once.and_return(response)
        client.should_receive(:post).with('oauth/access_token', params).once.and_return(response)
        client.xauth(username, password)
      end

      it "sets right token" do
        client.token.should eq('a')
      end

      it "sets right token_secret" do
        client.token_secret.should eq('b')
      end
    end

    context "when Invalid OAuth Request" do

      let(:response) do
        mock(Faraday::Response, status: 401, body: 'Invalid OAuth Request')
      end

      before do
        client.should_receive(:post).with('oauth/request_token').once.and_return(response)
      end

      it 'raises 401' do
        expect { client.xauth('', '') }.to raise_error(F00px::Error::Unauthorized)
      end
    end

    context "when passing invalid credentials" do

      let(:request_token_response) do
        mock(Faraday::Response, status: 200, body:'oauth_token=a&oauth_token_secret=b')
      end

      let(:access_token_response) do
        mock(Faraday::Response, status: 403, body: '')
      end

      let(:username) { 'user' }

      let(:password) { '' }

      let(:params) do
        { x_auth_mode: "client_auth", x_auth_username: username, x_auth_password: password}
      end

      before do
        client.should_receive(:post).with('oauth/request_token').once.and_return(request_token_response)
        client.should_receive(:post).with('oauth/access_token', params).once.and_return(access_token_response)
      end

      it 'raises 403' do
        expect { client.xauth(username, password) }.to raise_error(F00px::Error::Forbidden)
      end

      it 'cleans tokens' do
        client.xauth(username, password) rescue
        client.token.should be_nil
      end

    end
  end
end
