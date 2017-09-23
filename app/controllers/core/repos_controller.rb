module Core
  class ReposController < ApplicationController

    layout 'core'

    def index
      @repos = Repo.all
    end

    def show
      @repo = Repo.find(params["id"])
    end

    def new
      @repo = Repo.new
    end

    def create
      opts = params["repo"] || params["repo_git_hub"]
      @repo = Repo::GitHub.new(valid_params(opts))
      if @repo.save
        @repo.sync
        redirect_to("/repos/#{@repo.id}")
      else
        render 'repos/new'
      end
    end

    def destroy
      id = params["id"]
      @repo = Repo.find(id)
      @repo.destroy
      redirect_to "/repos"
    end

    def sync
      id = params["id"]
      @repo = Repo.find(id)
      @repo.sync
      redirect_to "/repos"
    end

    private

    def valid_params(params)
      fields = Repo.attribute_names.map(&:to_sym)
      params.permit(fields)
    end
  end
end
