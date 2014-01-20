require 'helper'

class ClientTest < Test::Unit::TestCase
  def setup
    token = "7d2d06f6381f9be18833d44c9361828c"
    @client = Pivotal::Client.new(token)
  end

  def test_accounts
    VCR.use_cassette('accounts') do
      @client.accounts.each do |account|
        assert_not_nil account.id
        assert_not_nil account.name
      end
    end
  end

  def test_single_account
    VCR.use_cassette('account') do
      account = @client.account(535789)
      assert_not_nil account.id
      assert_not_nil account.name
    end
  end

  def test_projects
    VCR.use_cassette('projects') do
      @client.projects.each do |project|
        assert_not_nil project.id
        assert_not_nil project.name
      end
    end
  end

  def test_single_project
    VCR.use_cassette('project') do
      project = @client.project(987666)
      assert_not_nil project.id
      assert_not_nil project.name
    end
  end

  def test_project_stories
    VCR.use_cassette('stories') do
      @client.stories(987666).each do |story|
        assert_not_nil story.id
      end
    end
  end

  def test_single_story
    VCR.use_cassette('story') do
      story = @client.story(63414462)
      assert_not_nil story.id
      assert_not_nil story.name
    end
  end
end
