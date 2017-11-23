module Docfix
  class ProjectsController < ApplicationController

    layout 'docfix'

    def index
      @query    = ProjectQuery.new(permitted(params["project_query"]))
      @projects = @query.search.paginate(page: params[:page], per_page: 5)
    end

    def show
      @project = Repo.find(params[:id])
    end

    def new
    end

    private

    def permitted(params)
      return nil if params.nil?
      params.permit(:readme_qry, :language_qry)
    end
  end
end
