module Docfix
  class IssuesController < ApplicationController

    layout 'docfix'

    before_action :authenticate_user!, :except => [:index, :show]

    def index
      @query = IssueQuery.new(permitted(params["issue_query"]))
      @bugs  = @query.search.paginate(page: params[:page], per_page: 5)
    end

    def show
      @fv  = "[0,0,0,0,2,4,15,16,19]"
      @uv  = "[19,15,16,4,0,0,0,0,0]"
      @bug = Issue.find(params["id"])
    end

    def offer_bf
      deposit = params[:deposit]    || 20
      vol     = params[:volume]     || 100
      mdate   = params[:maturation] || BugmTime.future_week_ends.first.strftime("%y-%m-%d")
      @bug      = Issue.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_issue_uuid: @bug.uuid, deposit: deposit, volume: vol, maturation: mdate})
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, opts).offer_new
    end

    def offer_bu
      deposit = params[:deposit]    || 80
      vol     = params[:volume]     || 100
      mdate   = params[:maturation] || BugmTime.future_week_ends.first.strftime("%y-%m-%d")
      @bug      = Issue.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_issue_uuid: @bug.uuid, deposit: deposit, volume: vol, maturation: mdate})
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, opts).offer_new
    end

    def offer_buy
      @bug   = Issue.find(params["id"])
      opts   = helpers.docfix_offer_base_opts(perm(params), {stm_issue_uuid: @bug.uuid})
      @offer = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end

    def match_bf
      deposit   = params[:deposit]    || 20
      vol       = params[:volume]     || 100
      mdate     = params[:maturation] || BugmTime.future_week_ends.first.strftime("%y-%m-%d")
      @offer    = Offer.find(params[:offer_id]) if params[:offer_id]
      @bug      = Issue.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_issue_uuid: @bug.uuid, deposit: deposit, volume: vol, maturation: mdate})
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end

    def match_bu
      deposit   = params[:deposit]    || 80
      vol       = params[:volume]     || 100
      mdate     = params[:maturation] || BugmTime.future_week_ends.first.strftime("%y-%m-%d")
      @offer    = Offer.find(params[:offer_id]) if params[:offer_id]
      @bug      = Issue.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_issue_uuid: @bug.uuid, deposit: deposit, volume: vol, maturation: mdate})
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, opts)
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

