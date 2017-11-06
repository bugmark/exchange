module Docfix
  class IssuesController < ApplicationController

    layout 'docfix'

    def index
      @bugs = Bug.all
    end

    def show
    end
  end
end

