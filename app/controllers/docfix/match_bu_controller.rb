module Docfix
  class MatchBuController < ApplicationController

    layout 'docfix'

    before_action :authenticate_user!, :except => [:index, :show, :resolve]

    def create
      core_opts = params["offer_cmd_create_buy"]
      base_opts = helpers.docfix_offer_base_opts(perm(core_opts))
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, base_opts)
      if @offer_bu.project
        cross = ContractCmd::Cross.new(@offer_bu.offer, :expand).project
        if cross
          contract = cross.contract
          flash[:notice] = "New contract is created"
          redirect_to ("/docfix/contracts/#{contract.id}")
        else
          @bug = @offer_bu.offer.bug
          flash.now["error"] = "Error!"
          render "docfix/issues/match_bu"
        end
      else
        @bug = @offer_bu.offer.bug
        flash.now["error"] = "Error!"
        render "docfix/issues/match_bu"
      end
    end

    private

    def perm(params)
      fields = Offer::Buy::Fixed.attribute_names.map(&:to_sym) + [:deposit, :maturation]
      params.permit(fields)
    end
  end
end
