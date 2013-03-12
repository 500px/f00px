require 'spec_helper'
describe F00px::Api::Photos do

  class TestClient
    include F00px::Api::Photos
    attr_accessor :url, :params

    def get(*args)
      @url, @params = args
    end
  end

  let(:client) do
    TestClient.new
  end

  describe ".popular" do

    before do
      client.popular
    end

    it "uses photos url" do
      client.url.should eq('photos')
    end

    it "sets the right feature" do
      client.params[:feature].should eq('popular')
    end
  end

  describe ".user_photos" do

    context "when making a normal call" do

      before do
        client.user_photos(10)
      end

      it "uses the right url" do
        client.url.should eq('photos')
      end

      it "sets the right user_id" do
        client.params[:user_id].should eq(10)
      end

      it "sets the right feature" do
        client.params[:feature].should eq('user')
      end
    end

    context "when passing multiple images sizes" do

      context "when using options" do

        before do
          client.user_photos(10, images: [2,3,4])
        end

        it "sets the right images array" do
          client.params[:image_size].should eq([2,3,4])
        end
      end

      context "when using the param builder" do

        let(:builder) do
          F00px::Api::Photos::Builder.new
            .images(3,4)
        end

        before do
          client.user_photos(10, builder)
        end

        it "sets the right images array" do
          client.params[:image_size].should eq([3,4])
        end
      end
    end
  end
end
