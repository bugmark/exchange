class EventsController < ApplicationController

  layout 'events'

  before_action :authenticate_user!, only: %i(new_login new_signup)

  def index
    @events = EventLine.paginate(page: params[:page], per_page: 20)
  end

  def show
    @event = EventLine.find(params["id"])
  end

  def new_login
  end

  def new_signup
  end
end

