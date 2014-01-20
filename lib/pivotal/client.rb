require 'pivotal/url_builder'
require 'pivotal/account'
require 'pivotal/project'
require 'pivotal/story'
require 'pivotal/comment'
require 'pivotal/epic'
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
        Pivotal::Project.new(raw_project['id'], raw_project['name'])
      end
    end

    def project(id)
      raw_project = get_response(project_path(id))
      Pivotal::Project.new(raw_project['id'], raw_project['name'])
    end

    def stories(project_id)
      raw_stories = get_response(stories_path(project_id))

      raw_stories.map do |raw_story|
        Pivotal::Story.new(raw_story['id'], raw_story['name'])
      end
    end

    def story(id)
      raw_story = get_response(story_path(id))
      Pivotal::Project.new(raw_story['id'], raw_story['name'])
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

      comments = raw_comments.map do |raw_comment|
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

    def http_options
      { headers: { 'X-TrackerToken' => token, 'Content-Type' => 'application/json' } }
    end
  end
end
