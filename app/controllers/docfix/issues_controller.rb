module Docfix
  class IssuesController < ApplicationController

    layout 'docfix'

    before_action :authenticate_user!, :except => [:index, :show]

    def index
      @query = IssueQuery.new(permitted(params["issue_query"]))
      @bugs  = @query.search.paginate(page: params[:page], per_page: 5)
    end

    def show
      @bug = Bug.find(params["id"])
    end

    def offer_bf
      @bug      = Bug.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_bug_id: @bug.id, stake: 10, volume: 50})
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end

    def offer_bu
      @bug      = Bug.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_bug_id: @bug.id, stake: 40, volume: 50})
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, opts)
    end

    def offer_buy
      @bug   = Bug.find(params["id"])
      opts   = helpers.docfix_offer_base_opts(perm(params), {stm_bug_id: @bug.id})
      @offer = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end

    private

    def perm(params)
      fields = Offer::Buy::Unfixed.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def permitted(params)
      return nil if params.nil?
      params.permit(:free_qry, :lang_qry, :offer_qry)
    end
  end
end

