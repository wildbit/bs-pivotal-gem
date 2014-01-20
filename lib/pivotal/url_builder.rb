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

    def stories_path(project_id)
      BASE_URL % "projects/#{project_id}/stories"
    end

    def story_path(id)
      BASE_URL % "stories/#{id}"
    end

    def epics_path(project_id)
      "#{project_path(project_id)}/epics"
    end

    def epic_path(project_id, id)
      "#{epics_path(project_id)}/#{id}"
    end

    def comments_path(project_id, story_id)
      BASE_URL % "projects/#{project_id}/stories/#{story_id}/comments"
    end

    def comment_path(project_id, story_id, comment_id)
      "#{comments_path(project_id, story_id)}/#{comment_id}"
    end
  end
end
