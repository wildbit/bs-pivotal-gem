require 'helper'

class StoriesTest < PivotalTestCase
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
      assert_not_nil story.id, "Story ID is nil"
      assert_not_nil story.name, "Story name is nil"
    end
  end

  def test_unknown_story
    VCR.use_cassette('unknown_story') do
      assert_raise Pivotal::PivotalError do
        @client.story(0)
      end
    end
  end

  def test_change_to_valid_state
    VCR.use_cassette('change_story_state') do
      VCR.use_cassette('story') do
        story = @client.change_story_state(@project_id, @story_id, 'started')
        assert_not_nil story.id, "Story ID is nil"
        assert_not_nil story.name, "Story name is nil"
      end
    end
  end

  def test_change_to_invalid_state
    VCR.use_cassette('story') do
      assert_raise Pivotal::UnknownStateError do
        @client.change_story_state(@project_id, @story_id, 'xzy')
      end
    end
  end

  def test_change_owned_by_id
    VCR.use_cassette('change_story_owner') do
      story = @client.update_story_owner(@story_id, @user_id)
      assert_not_nil story.id, "Story ID is nil"
      assert_not_nil story.name, "Story name is nil"
      assert_equal @user_id, story.owned_by_id, "Story owner doesn't match given user id"
    end
  end

  def test_change_state_when_not_estimated
    VCR.use_cassette('unestimated_story') do
      assert_raise Pivotal::StoryNotEstimatedError do
        @client.change_story_state(@project_id, @unestimated_story_id, 'started')
      end
    end
  end
end
