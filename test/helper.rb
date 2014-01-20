require 'bundler'
require 'test/unit'
require 'pivotal'
require 'vcr'
require 'turn'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.default_cassette_options = { :serialize_with => :json }
  c.hook_into :webmock
end
