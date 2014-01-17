require 'pivotal/url_builder'
require 'pivotal/models'
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
        Pivotal::Models::Project.new(raw_project['id'], raw_project['name'])
      end
    end

    def project(id)
      raw_project = get_response(project_path(id))
      Pivotal::Models::Project.new(raw_project['id'], raw_project['name'])
    end

    def stories(project_id)
    end

    def accounts
      raw_accounts = get_response(accounts_path)

      raw_accounts.map do |raw_account|
        Pivotal::Models::Account.new(raw_account['id'], raw_account['name'])
      end
    end

    def account(id)
      raw_account = get_response(account_path(id))
      Pivotal::Models::Account.new(raw_account['id'], raw_account['name'])
    end

    private

    def get_response(path)
      raw_response = self.class.get(path, http_options)
      JSON.parse(raw_response.body)
    end

    def http_options
      { headers: { 'X-TrackerToken' => token } }
    end
  end
end
