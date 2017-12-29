module Core
  class OffersBuController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    def new
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, new_opts(params))
    end

    def create
      opts = params["offer_cmd_create_buy"]
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, new_opts.merge(valid_params(opts)))
      if @offer_bu.project
        flash[:notice] = "Offer created! (BU)"
        redirect_to("/core/offers/#{@offer_bu.id}")
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
      key = "stm_bug_id" if params["stm_bug_id"]
      key = "stm_repo_id" if params["stm_repo_id"]
      id = params["stm_bug_id"] || params["stm_repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
