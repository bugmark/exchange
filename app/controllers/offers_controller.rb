class OffersController < ApplicationController

  def index
    @bids = Bid.unassigned
    @asks = Ask.unassigned
  end

  def cross
    ask_id = params["id"]
    result = ContractCmd::Cross.new(ask_id).save_event.project
    if result
      redirect_to "/contracts/#{result.id}"
    else
      redirect_to "/contracts"
    end
  end
end