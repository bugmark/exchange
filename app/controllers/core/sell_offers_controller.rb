module Core
  class SellOffersController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    def index
      @bids = Bid.unassigned
      @asks = Ask.unassigned
    end

    def new
      @position_id = params["position_id"]
      @position    = Position.find(@position_id)
      attrs = {volume: @position.volume, price: @volume.price}
      @bid = OfferCmd::CreateSell.new(@position, attrs)
    end
  end
end