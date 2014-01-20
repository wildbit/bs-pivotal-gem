require 'helper'

class LabelsTest < PivotalTestCase
  def test_project_labels
    VCR.use_cassette('project_labels') do
      @client.project_labels(@project_id).each do |label|
        assert_not_nil label.id, "Label ID was nil"
        assert_not_nil label.name, "Label name was nil"
      end
    end
  end

  def test_assign_label_to_story
    VCR.use_cassette('new_project_story_label') do
      name = "My Awesome Label"
      label = @client.assign_label_to_story(@project_id, @story_id, name)
      assert_not_nil label.id, "Label ID was nil"
      assert_not_nil label.name, "Label name was nil"
      assert_equal name.downcase, label.name
    end
  end
end
