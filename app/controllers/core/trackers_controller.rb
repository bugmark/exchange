module Core
  class TrackersController < ApplicationController

    layout 'core'

    def index
      @trackers = Tracker.all
    end

    def show
      @tracker = Tracker.find_by_uuid(params["id"])
    end

    def new
      @tracker = Tracker.new
    end

    def create
      opts = params["tracker"] || params["tracker_git_hub"]
      @tracker = Tracker::GitHub.new(valid_params(opts))
      if @tracker.save
        @tracker.sync
        redirect_to("/trackers/#{@tracker.id}")
      else
        render 'trackers/new'
      end
    end

    def destroy
      id = params["id"]
      @tracker = Tracker.find(id)
      @tracker.destroy
      redirect_to "/trackers"
    end

    def sync
      id = params["id"]
      @tracker = Tracker.find(id)
      @tracker.sync
      redirect_to "/trackers"
    end

    private

    def valid_params(params)
      fields = Tracker.attribute_names.map(&:to_sym)
      params.permit(fields)
    end
  end
end
