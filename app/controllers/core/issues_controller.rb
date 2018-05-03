module Core
  class IssuesController < ApplicationController

    layout 'core'

    # stm_tracker_uuid (optional)
    def index
      if stm_tracker_uuid = params["stm_tracker_uuid"]
        @tracker   = Tracker.find_by_uuid(stm_tracker_uuid)
        @issues = @tracker.issues
      else
        @tracker   = nil
        @issues = Issue.all
      end
    end

    def show
      @issue = Issue.find_by_uuid(params["id"])
    end
  end
end
