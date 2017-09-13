class PredictionsController < ApplicationController

  def index
    @bids = Bid.unassigned
    @asks = Ask.unassigned
  end
end