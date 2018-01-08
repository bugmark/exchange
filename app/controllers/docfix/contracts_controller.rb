module Docfix
  class ContractsController < ApplicationController

    layout 'docfix'

    def index
      @sort      = params[:sort] || ""
      @query     = ContractQuery.new
      @contracts = Contract.inc_volsum.paginate(page: params[:page], per_page: 5).order(pick_sort(@sort))
    end

    def show
      @contract = Contract.find(params[:id])
    end

    def offer_buy
      @contract = Contract.find(params["id"])
      @bug      = @contract.bug
      opts   = helpers.docfix_offer_base_opts(perm(params), {stm_bug_uuid: @bug.uuid})
      @offer = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end

    private

    def pick_sort(item)
      return "" if item.match(/xx/) || item.blank?
      case item
        when "date_up"   then "maturation asc"
        when "date_dn"   then "maturation desc"
        when "volsum_up" then "volsum asc"
        when "volsum_dn" then "volsum desc"
        else ""
      end
    end

  end
end

