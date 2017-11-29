module Docfix
  class ContractsController < ApplicationController

    layout 'docfix'

    def index
      @query     = ContractQuery.new
      @contracts = Contract.paginate(page: params[:page], per_page: 5)
    end

    def show
      @contract = Contract.find(params[:id])
    end

    def offer_buy
      @contract = Contract.find(params["id"])
      @bug      = @contract.bug
      opts   = helpers.docfix_offer_base_opts(perm(params), {stm_bug_id: @bug.id})
      @offer = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end
  end
end

