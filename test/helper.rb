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

class PivotalTestCase < Test::Unit::TestCase
  def setup
    token = "7d2d06f6381f9be18833d44c9361828c"
    @client = Pivotal::Client.new(token)

    @account_id = 535789
    @project_id = 987666
    @story_id = 63414462
    @unestimated_story_id = 64181792
    @chore_story_id = 70441578
    @story_comment_id = 59955332
    @epic_comment_id = 59968756
    @epic_id = 1017976
    @user_id = 1033785
  end
end
