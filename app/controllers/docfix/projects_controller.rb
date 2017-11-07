module Docfix
  class ProjectsController < ApplicationController

    layout 'docfix'

    def index
      @projects = Repo.paginate(page: params[:page], per_page: 5)
    end

    def show
      @project = Repo.find(params[:id])
    end

    def new
    end
  end
end

