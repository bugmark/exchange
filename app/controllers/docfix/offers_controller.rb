module Docfix
  class OffersController < ApplicationController

    layout 'docfix'

    def index
      @query  = OfferQuery.new
      @offers = Offer.paginate(page: params[:page], per_page: 5)
    end

    def show
      @offer = Offer.find(params["id"])
    end

    def cross
      offer   = Offer.find(params["id"])
      result1 = ContractCmd::Cross.new(offer, :expand).project
      result2 = ContractCmd::Cross.new(offer, :transfer).project
      if result1 || result2
        redirect_to "/docfix/contracts/#{offer.position.contract.id}"
      else
        redirect_to "/docfix/offers/#{offer.id}"
      end
    end

  end
end

