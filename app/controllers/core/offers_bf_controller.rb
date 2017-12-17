module Core
  class OffersBfController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve]

    def new
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, new_opts(params))
    end

    def create
      opts = params["offer_cmd_create_buy"]
      @offer_bf = OfferCmd::CreateBuy.new(:offer_bf, new_opts.merge(valid_params(opts)))
      if @offer_bf.project
        flash[:notice] = "Offer created! (BF)"
        redirect_to("/core/offers/#{@offer_bf.id}")
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
        price:      0.50                      ,
        poolable:   false                     ,
        aon:        false                     ,
        volume:     10                        ,
        status:     'open'                    ,
        stm_status: "closed"                  ,
        maturation: BugmTime.now + 3.minutes  ,
        user:       current_user
      }
      key = "stm_bug_id" if params["stm_bug_id"]
      key = "stm_repo_id" if params["stm_repo_id"]
      id = params["stm_bug_id"] || params["stm_repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
