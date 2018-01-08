module Core
  class OffersBfController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve]

    def new
      new_opts = new_opts(params)
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, new_opts).offer_new
    end

    def create
      opts = params["offer_buy_fixed"]
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, new_opts.merge(valid_params(opts)))
      if @offer_bf.project
        flash[:notice] = "Offer created! (BF)"
        redirect_to("/core/offers/#{@offer_bf.offer.uuid}")
      else
        render 'core/offers_bf/new'
      end
    end

    private

    def valid_params(params)
      fields = Offer::Buy::Fixed.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def new_opts(params = {})
      opts = {
        price:      0.20                      ,
        poolable:   false                     ,
        aon:        false                     ,
        volume:     10                        ,
        stm_status: "closed"                  ,
        maturation: BugmTime.now + 3.minutes  ,
        user_uuid:  current_user.uuid
      }
      key = "stm_bug_uuid" if params["stm_bug_uuid"]
      key = "stm_repo_uuid" if params["stm_repo_uuid"]
      id = params["stm_bug_uuid"] || params["stm_repo_uuid"]
      opts.merge({key => id}).without_blanks.stringify_keys
    end
  end
end
