module Docfix
  class OffersBuController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    def create
      core_opts = params["offer_cmd_create_buy"]
      base_opts = helpers.docfix_offer_base_opts(perm(core_opts))
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, base_opts)
      if @offer_bu.save_event.project
        redirect_to("/docfix/offers/#{@offer_bu.id}")
      else
        render 'docfix/offers_bu/new'
      end
    end

    private

    def perm(params)
      fields = Offer::Buy::Unfixed.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

  end
end
