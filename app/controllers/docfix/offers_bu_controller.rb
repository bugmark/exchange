module Docfix
  class OffersBuController < ApplicationController

    layout 'docfix'

    before_action :authenticate_user!, :except => [:index, :show]

    def create
      core_opts = params["offer_cmd_create_buy"]
      base_opts = helpers.docfix_offer_base_opts(perm(core_opts))
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, base_opts)
      if @offer_bu.project
        redirect_to("/docfix/offers/#{@offer_bu.offer.id}")
      else
        @bug = @offer_bu.offer.issue
        render "docfix/issues/offer_bu"
      end
    end

    private

    def perm(params)
      fields = Offer::Buy::Unfixed.attribute_names.map(&:to_sym) + [:deposit]
      params.permit(fields)
    end

  end
end
