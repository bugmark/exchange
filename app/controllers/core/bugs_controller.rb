module Core
  class BugsController < ApplicationController

    layout 'core'

    # stm_repo_id (optional)
    def index
      if stm_repo_id = params["stm_repo_id"]&.to_i
        @repo = Repo.find(stm_repo_id)
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
