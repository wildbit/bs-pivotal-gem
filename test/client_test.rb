require 'helper'

class ClientTest < Test::Unit::TestCase
  def setup
    token = "7d2d06f6381f9be18833d44c9361828c"
    @client = Pivotal::Client.new(token)

    @account_id = 535789
    @project_id = 987666
    @story_id = 63414462
    @comment_id = 59955332
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
      account = @client.account(@account_id)
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
      project = @client.project(@project_id)
      assert_not_nil project.id
      assert_not_nil project.name
    end
  end

  def test_project_stories
    VCR.use_cassette('stories') do
      @client.stories(@project_id).each do |story|
        assert_not_nil story.id
      end
    end
  end

  def test_single_story
    VCR.use_cassette('story') do
      story = @client.story(@story_id)
      assert_not_nil story.id
      assert_not_nil story.name
    end
  end

  def test_story_comments
    VCR.use_cassette('comments') do
      @client.comments(@project_id, @story_id).each do |comment|
        assert_not_nil comment.id, "Comment ID was nil"
        assert_not_nil comment.text, "Comment text was nil"
      end
    end
  end

  def test_single_story_comment
    VCR.use_cassette('new_comment') do
      comment = @client.new_comment(@project_id, @story_id, "My New Comment")
      assert_not_nil comment.id, "Comment ID was nil"
      assert_not_nil comment.text, "Comment text was nil"
    end
  end

  def test_create_story_comment

  end
end
