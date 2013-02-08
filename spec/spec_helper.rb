require "f00px"
require 'rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into :faraday
  c.default_cassette_options = { :record => :once }
end

RSpec.configure do |c|
  c.mock_with :rspec
end
