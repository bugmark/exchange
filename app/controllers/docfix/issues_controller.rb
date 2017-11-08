module Docfix
  class IssuesController < ApplicationController

    layout 'docfix'

    before_action :authenticate_user!, :except => [:index, :show]

    def index
      @bugs = Bug.paginate(page: params[:page], per_page: 5)
    end

    def show
      @bug = Bug.find(params["id"])
    end

    def offer_bf
      @bug      = Bug.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_bug_id: @bug.id})
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, opts)
    end

    def offer_bu
      @bug      = Bug.find(params["id"])
      opts      = helpers.docfix_offer_base_opts(perm(params), {stm_bug_id: @bug.id})
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

  end
end

