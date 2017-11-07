module Docfix
  class ProjectsController < ApplicationController

    layout 'docfix'

    def index
      @projects = Repo.all
    end

    def show
    end

    def new
    end
  end
end

