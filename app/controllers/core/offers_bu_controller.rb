module Core
  class OffersBuController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    def new
      new_opts = new_opts(params)
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, new_opts).offer_new
      binding.pry
      x = 1
    end

    def create
      opts = params["offer_buy_unfixed"]
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, new_opts.merge(valid_params(opts)))
      if @offer_bu.project
        flash[:notice] = "Offer created! (BU)"
        redirect_to("/core/offers/#{@offer_bu.offer.uuid}")
      else
        render 'core/offers_bu/new'
      end
    end

    private

    def valid_params(params)
      fields = Offer::Buy::Unfixed.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def new_opts(params = {})
      opts = {
        price:       0.80                     ,
        poolable:    false                    ,
        aon:         false                    ,
        volume:      10                       ,
        user_uuid:   current_user.uuid        ,
        stm_status:  "closed"                 ,
        maturation:  BugmTime.now + 3.minutes ,
      }
      key = "stm_bug_uuid" if params["stm_bug_uuid"]
      key = "stm_repo_uuid" if params["stm_repo_uuid"]
      id = params["stm_bug_uuid"] || params["stm_repo_uuid"]
      opts.merge({key => id}).without_blanks.stringify_keys
    end
  end
end
