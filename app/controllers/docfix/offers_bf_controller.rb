module Docfix
  class OffersBfController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve]

    def create
      core_opts = params["offer_cmd_create_buy"]
      base_opts = helpers.docfix_offer_base_opts(perm(core_opts))
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, base_opts)
      if @offer_bf.save_event.project
        redirect_to("/docfix/offers/#{@offer_bf.id}")
      else
        render 'docfix/offers_bf/new'
      end
    end

    private

    def perm(params)
      fields = Offer::Buy::Fixed.attribute_names.map(&:to_sym)
      params.permit(fields)
    end
  end
end
