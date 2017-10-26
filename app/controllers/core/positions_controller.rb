module Core
  class PositionsController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    def index
      @positions = Position.all
    end

    def show
      @position = Position.find(params["id"])
    end

  end
end
