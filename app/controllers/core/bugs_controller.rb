module Core
  class BugsController < ApplicationController

    layout 'core'

    # stm_repo_uuid (optional)
    def index
      if stm_repo_uuid = params["stm_repo_uuid"]
        @repo = Repo.find_by_uuid(stm_repo_uuid)
        @bugs = @repo.issues
      else
        @repo = nil
        @bugs = Issue.all
      end
    end

    def show
      @bug = Issue.find_by_uuid(params["id"])
    end
  end
end
