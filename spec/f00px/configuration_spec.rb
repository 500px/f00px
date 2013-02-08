require 'spec_helper'

describe F00px::Configuration do

  class TestConfig
    include F00px::Configuration
  end

  describe ".configure" do

    let(:klass) do
      TestConfig
    end

    let(:instance) do
      TestConfig.new
    end

    context "when using configure method" do

      context "when passing a block" do

        before do
          instance.configure do |c|
            c.consumer_key = "consumer_key_123"
          end
        end

        it "sets the consumer_key" do
          instance.consumer_key.should eq("consumer_key_123")
        end
      end

      context "when not passing a block" do

        before do
          c = instance.configure
          c.consumer_secret = "secret!"
        end

        it "sets the consumer_key" do
          instance.consumer_secret.should eq("secret!")
        end
      end
    end

    context "when not setting a var" do

      it "returns nil if no default" do
        instance.consumer_secret.should be_nil
      end

      it "returns default" do
        instance.endpoint.should_not be_nil
      end
    end
  end

  describe ".credentials" do

    let(:klass) do
      TestConfig
    end

    let(:instance) do
      TestConfig.new
    end

    context "when setting up all credentials" do

      let(:credentials) do
        { consumer_key: 'a', consumer_secret: 'b',
          token: 'c', token_secret: 'd'
        }
      end

      before do
        instance.configure do |c|
          credentials.keys.each do |key|
            c.send("#{key}=", credentials[key])
          end
        end
      end

      it "matches all credentials" do
        instance.credentials.should eq(credentials)
      end
    end
  end

end
