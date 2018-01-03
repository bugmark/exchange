module Core
  class BugsController < ApplicationController

    layout 'core'

    # stm_repo_uuid (optional)
    def index
      if stm_repo_uuid = params["stm_repo_uuid"]
        @repo = Repo.find_by_uuid(stm_repo_uuid)
        @bugs = @repo.bugs
      else
        @repo = nil
        @bugs = Bug.all
      end
    end

    def show
      @bug = Bug.find(params["id"])
    end
  end
end
