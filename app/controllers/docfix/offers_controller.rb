module Docfix
  class OffersController < ApplicationController

    layout 'docfix'

    def index
      @sort   = params[:sort] || ""
      tst_log @sort
      tst_log params.inspect
      @query  = OfferQuery.new
      @offers = Offer.paginate(page: params[:page], per_page: 5).order(pick_sort(@sort))
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

    private

    def pick_sort(item)
      return "" if item.match(/xx/) || item.blank?
      case item
        when "status_up" then "stm_status asc"
        when "status_dn" then "stm_status desc"
        when "price_up"  then "value asc"
        when "price_dn"  then "value desc"
        when "prob_up"   then "price asc"
        when "prob_dn"   then "price desc"
        when "trade_up"  then "price asc"
        when "trade_dn"  then "price desc"
        else ""
      end
    end
  end
end

