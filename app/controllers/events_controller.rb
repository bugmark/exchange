class EventsController < ApplicationController

  layout 'events'

  def index
    @events = EventLine.paginate(page: params[:page], per_page: 20)
  end

  def show
    @event = EventLine.find(params["id"])
  end
end

