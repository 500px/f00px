require 'spec_helper'

describe F00px::Configuration::Options do

  class TestOptions
    include F00px::Configuration::Options

    option :a, default: 'a_default'
    option :b
    option :c
  end

  let(:klass) do
    TestOptions
  end

  describe "#defaults" do

    it "has default for a" do
      klass.defaults[:a].should eq('a_default')
    end

    it "has not default for b" do
      klass.defaults[:b].should be_nil
    end
  end

  describe "#options" do

    it "includes option a" do
      klass.options.should include(:a)
    end

    it "includes option b" do
      klass.options.should include(:b)
    end

    it "includes option c" do
      klass.options.should include(:c)
    end
  end

  describe ".\#{option_name}" do

    let(:instance) do
      klass.new
    end

    context "when field has default" do

      it "has default value" do
        instance.a.should eq('a_default')
      end
    end

    context "when field does not have a default" do

      it "returns nil" do
        instance.b.should be_nil
      end
    end
  end

  describe ".\#{option_name}=" do

    let(:instance) do
      klass.new
    end

    context "when field has default" do

      before do
        instance.a = "new val"
      end

      it "has new value" do
        instance.a.should eq('new val')
      end
    end

    context "when field does not have a default" do

      before do
        instance.b = "b val"
      end

      it "has new value" do
        instance.b.should eq("b val")
      end
    end
  end
end
