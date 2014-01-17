module Pivotal
  module UrlBuilder
    extend self

    BASE_URL = "https://www.pivotaltracker.com/services/v5/%s"

    def projects_path
      BASE_URL % "projects"
    end

    def project_path(id)
      BASE_URL % "projects/#{id}"
    end

    def accounts_path
      BASE_URL % "accounts"
    end

    def account_path(id)
      BASE_URL % "accounts/#{id}"
    end
  end
end
