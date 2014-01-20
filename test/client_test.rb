require 'helper'

class ClientTest < PivotalTestCase
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

  def test_epics
    VCR.use_cassette('epics') do
      @client.epics(@project_id).each do |epic|
        assert_not_nil epic.id, "Epic ID was nil"
      end
    end
  end

  def test_single_epic
    VCR.use_cassette('epic') do
      epic = @client.epic(@project_id, @epic_id)
      assert_not_nil epic.id, "Epic ID was nil"
    end
  end
end
