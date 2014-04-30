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

  def test_change_state_when_not_estimated_for_feature_story
    VCR.use_cassette('unestimated_story') do
      assert_raise Pivotal::StoryNotEstimatedError do
        @client.change_story_state(@project_id, @unestimated_story_id, 'started')
      end
    end
  end

  def test_change_state_when_not_estimated_for_chore_story
    VCR.use_cassette('unestimated_chore') do
      assert_equal nil, @client.story(@chore_story_id).estimate
      chore = @client.change_story_state(@project_id, @chore_story_id, 'started')
      assert_equal 'started', chore.state
    end
  end

  def test_story_is_feature?
    VCR.use_cassette('story') do
      assert @client.story(@story_id).feature?
    end
  end

  def test_story_is_chore?
    VCR.use_cassette('chore') do
      assert @client.story(@chore_story_id).chore?
    end
  end
end
