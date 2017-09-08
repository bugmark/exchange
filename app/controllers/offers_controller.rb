class OffersController < ApplicationController

  def index
    @bids = Bid.all
    @asks = Ask.all
  end

end
