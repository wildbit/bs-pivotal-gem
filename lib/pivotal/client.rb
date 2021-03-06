require 'pivotal/url_builder'
require 'pivotal/account'
require 'pivotal/project'
require 'pivotal/story'
require 'pivotal/comment'
require 'pivotal/epic'
require 'pivotal/label'
require 'pivotal/user'
require 'httparty'
require 'json'

module Pivotal
  class Client
    include HTTParty
    include UrlBuilder

    attr_accessor :token

    def initialize(token)
      self.token = token
    end

    def projects
      raw_projects = get_response(projects_path)

      raw_projects.map do |raw_project|
        Pivotal::Project.new(raw_project['id'], raw_project['name'], raw_project['account_id'])
      end
    end

    def project(id)
      raw_project = get_response(project_path(id))
      Pivotal::Project.new(raw_project['id'], raw_project['name'], raw_project['account_id'])
    end

    def stories(project_id)
      raw_stories = get_response(stories_path(project_id))

      raw_stories.map do |raw_story|
        Pivotal::Story.build(raw_story)
      end
    end

    def story(id)
      raw_story = get_response(story_path(id))

      if raw_story['id'].nil?
        raise Pivotal::PivotalError.new("Story ##{id} was not found")
      end

      Pivotal::Story.build(raw_story)
    end

    def epics(project_id)
      raw_epics = get_response(epics_path(project_id))

      raw_epics.map do |raw_epic|
        Pivotal::Epic.new(raw_epic['id'], raw_epic['name'])
      end
    end

    def epic(project_id, id)
      raw_epic = get_response(epic_path(project_id, id))
      Pivotal::Epic.new(raw_epic['id'], raw_epic['name'])
    end

    def accounts
      raw_accounts = get_response(accounts_path)

      raw_accounts.map do |raw_account|
        Pivotal::Account.new(raw_account['id'], raw_account['name'])
      end
    end

    def account(id)
      raw_account = get_response(account_path(id))
      Pivotal::Account.new(raw_account['id'], raw_account['name'])
    end

    def story_comments(project_id, story_id)
      raw_comments = get_response(story_comments_path(project_id, story_id))

      raw_comments.map do |raw_comment|
        Pivotal::Comment.new(raw_comment['id'], raw_comment['text'])
      end
    end

    def story_comment(project_id, story_id, comment_id)
      raw_comment = get_response(story_comment_path(project_id, story_id, comment_id))
      Pivotal::Comment.new(raw_comment['id'], raw_comment['text'])
    end

    def new_story_comment(project_id, story_id, text)
      raw_comment = post_response(story_comments_path(project_id, story_id), text: text)
      Pivotal::Comment.new(raw_comment['id'], raw_comment['text'])
    end

    def epic_comments(project_id, epic_id)
      raw_comments = get_response(epic_comments_path(project_id, epic_id))

      raw_comments.map do |raw_comment|
        Pivotal::Comment.new(raw_comment['id'], raw_comment['text'])
      end
    end

    def epic_comment(project_id, epic_id, comment_id)
      raw_comment = get_response(epic_comment_path(project_id, epic_id, comment_id))
      Pivotal::Comment.new(raw_comment['id'], raw_comment['text'])
    end

    def new_epic_comment(project_id, epic_id, text)
      raw_comment = post_response(epic_comments_path(project_id, epic_id), text: text)
      Pivotal::Comment.new(raw_comment['id'], raw_comment['text'])
    end

    def project_labels(project_id)
      raw_labels = get_response(project_labels_path(project_id))

      raw_labels.map do |raw_label|
        Pivotal::Label.new(raw_label['id'], raw_label['name'])
      end
    end

    def assign_label_to_story(project_id, story_id, name)
      raw_label = post_response(project_story_labels_path(project_id, story_id), name: name.to_s.downcase)
      Pivotal::Label.new(raw_label['id'], raw_label['name'])
    end

    def change_story_state(project_id, story_id, state)
      story = story(story_id)

      if story.feature? && story.estimate.nil?
        raise Pivotal::StoryNotEstimatedError.new("Story ##{story_id} must be estimated first")
      elsif Pivotal::Story::STATES.include?(state)
        raw_story = put_response(project_story_path(project_id, story_id), current_state: state.to_s.downcase)
        Pivotal::Story.build(raw_story)
      else
        raise Pivotal::UnknownStateError.new("#{state} is not a valid story state")
      end
    end

    def users(account_id)
      raw_users = get_response(users_path(account_id))

      raw_users.map do |raw_user|
        Pivotal::User.new(raw_user['id'], raw_user['person']['name'], raw_user['person']['username'], raw_user['person']['initials'])
      end
    end

    def user(account_id, user_id)
      raw_user = get_response(user_path(account_id, user_id))
      Pivotal::User.new(raw_user['id'], raw_user['person']['name'], raw_user['person']['username'], raw_user['person']['initials'])
    end

    def update_story_owner(story_id, user_id)
      raw_story = put_response(story_path(story_id), owned_by_id: user_id.to_i)
      Pivotal::Story.build(raw_story)
    end

    private

    def get_response(path)
      raw_response = self.class.get(path, http_options)
      JSON.parse(raw_response.body)
    end

    def post_response(path, post_body)
      json_body = JSON(post_body)
      raw_response = self.class.post(path, http_options.merge(body: json_body))
      JSON.parse(raw_response.body)
    end

    def put_response(path, put_body)
      json_body = JSON(put_body)
      raw_response = self.class.put(path, http_options.merge(body: json_body))
      JSON.parse(raw_response.body)
    end

    def http_options
      { headers: { 'X-TrackerToken' => token, 'Content-Type' => 'application/json' } }
    end
  end
end
