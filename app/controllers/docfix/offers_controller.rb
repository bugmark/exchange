module Docfix
  class OffersController < ApplicationController

    layout 'docfix'

    def index
      @offers = Offer.paginate(page: params[:page], per_page: 5)
    end

    def show
      @offer = Offer.find(params["id"])
    end
  end
end

