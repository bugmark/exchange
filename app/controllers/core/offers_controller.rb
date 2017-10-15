module Core
  class OffersController < ApplicationController

    layout 'core'

    def index
      @bids = Offer::Buy::Bid.unassigned
      @asks = Offer::Buy::Ask.unassigned
    end

    def cross
      ask_id = params["id"]
      result = ContractCmd::Cross.new(ask_id).save_event.project
      if result
        redirect_to "/rewards/#{result.id}"
      else
        redirect_to "/rewards"
      end
    end
  end
end