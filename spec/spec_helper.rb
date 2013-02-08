require "f00px"
require 'rspec'

RSpec.configure do |c|
  c.mock_with :rspec

  c.treat_symbols_as_metadata_keys_with_true_values = true
end

# load env vars
require 'support/env'
env_filename = File.join(File.dirname(__FILE__), '../.env').to_s
if File.exists? env_filename
  Env.new(env_filename).entries do |name, value|
    ENV[name] = value
  end
end


Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each {|f| require f}
