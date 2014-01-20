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

  def test_change_to_valid_state
    VCR.use_cassette('change_story_state') do
      story = @client.change_story_state(@project_id, @story_id, 'started')
      assert_not_nil story.id, "Story ID is nil"
      assert_not_nil story.name, "Story name is nil"
    end
  end

  def test_change_to_invalid_state
    assert_raise Pivotal::UnknownStateError do
      @client.change_story_state(@project_id, @story_id, 'xzy')
    end
  end
end
