class OffersController < ApplicationController

  def index
    @bids = Bid.unassigned
    @asks = Ask.unassigned
  end

  def cross
    ask_id = params["id"]
    result = RewardCmd::Cross.new(ask_id).save_event.project
    if result
      redirect_to "/rewards/#{result.id}"
    else
      redirect_to "/rewards"
    end
  end
end