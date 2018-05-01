module Core
  class IssuesController < ApplicationController

    layout 'core'

    # stm_repo_uuid (optional)
    def index
      if stm_repo_uuid = params["stm_repo_uuid"]
        @repo   = Repo.find_by_uuid(stm_repo_uuid)
        @issues = @repo.issues
      else
        @repo   = nil
        @issues = Issue.all
      end
    end

    def show
      @issue = Issue.find_by_uuid(params["id"])
    end
  end
end
