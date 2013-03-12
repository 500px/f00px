require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into :faraday

  c.allow_http_connections_when_no_cassette = true

  if !!ENV['RERECORD'] && ENV['RERECORD'] == 'true'
    c.default_cassette_options = {:record => :all}
  else
    c.default_cassette_options = {:record => :none}
  end

  c.filter_sensitive_data("Auth <SECRET>") { |i| [i.request.headers['Authorization']].flatten.first }
  c.filter_sensitive_data("Cookie <SECRET>") { |i| [i.response.headers['Set-Cookie']].flatten.first }

  c.configure_rspec_metadata!
end
