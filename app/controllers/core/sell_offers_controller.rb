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
      attrs = {volume: @position.volume, price: @position.price}
      @offer = OfferCmd::CreateSell.new(@position, attrs)
    end

    def create
      options  = params["offer_cmd_create_sell"]
      position = Position.find(options["parent_position_id"])
      @offer   = OfferCmd::CreateSell.new(position, lcl_opts(options, position))
      binding.pry
      if @offer.save_event.project
        redirect_to("/core/offers/#{@offer.id}")
      else
        render "/core/sell_offers/new"
      end
    end

    private

    def lcl_opts(params, position)
      defaults = {
        poolable: false ,
        aon:      false
      }
      opts = params.merge(position.offer.match_attrs).merge(defaults)
      params.permit(opts.keys)
    end
  end
end