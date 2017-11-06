module Docfix
  class IssuesController < ApplicationController

    layout 'docfix'

    def index
      @bugs = Bug.paginate(page: params[:page], per_page: 5)
    end

    def show
      @bug = Bug.find(params["id"])
    end
  end
end

