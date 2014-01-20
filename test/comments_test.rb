require 'helper'

class CommentsTest < PivotalTestCase
  def test_story_comments
    VCR.use_cassette('story_comments') do
      @client.story_comments(@project_id, @story_id).each do |comment|
        assert_not_nil comment.id, "Story Comment ID was nil"
        assert_not_nil comment.text, "Story Comment text was nil"
      end
    end
  end

  def test_single_story_comment
    VCR.use_cassette('new_story_comment') do
      comment = @client.new_story_comment(@project_id, @story_id, "My New Comment")
      assert_not_nil comment.id, "Story Comment ID was nil"
      assert_not_nil comment.text, "Story Comment text was nil"
    end
  end

  def test_epic_comments
    VCR.use_cassette('epic_comments') do
      @client.epic_comments(@project_id, @epic_id).each do |comment|
        assert_not_nil comment.id, "Epic Comment ID was nil"
        assert_not_nil comment.text, "Epic Comment text was nil"
      end
    end
  end

  def test_single_epic_comment
    VCR.use_cassette('new_epic_comment') do
      comment = @client.new_epic_comment(@project_id, @epic_id, "My New Epic Comment")
      assert_not_nil comment.id, "Epic Comment ID was nil"
      assert_not_nil comment.text, "Epic Comment text was nil"
    end
  end
end
