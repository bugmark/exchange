module Core
  class OffersBuController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    # def index
    #   @bug = @repo = nil
    #   @timestamp = Time.now.strftime("%H:%M:%S")
    #   case
    #     when stm_bug_id = params["stm_bug_id"]&.to_i
    #       @bug = Bug.find(stm_bug_id)
    #       @offer_bus = Offer::Buy::Unfixed.where(stm_bug_id: stm_bug_id)
    #     when stm_repo_id = params["stm_repo_id"]&.to_i
    #       @repo = Repo.find(stm_repo_id)
    #       @offer_bus = Offer::Buy::Unfixed.where(stm_repo_id: stm_repo_id)
    #     else
    #       @offer_bus = Offer::Buy::Unfixed.all
    #   end
    # end

    def new
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, new_opts(params))
    end

    def create
      opts = params["offer_cmd_create_buy"]
      @offer_bu = OfferCmd::CreateBuy.new(:offer_bu, new_opts.merge(valid_params(opts)))
      if @offer_bu.save_event.project
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
        price:       0.50                     ,
        poolable:    false                    ,
        aon:         false                    ,
        volume:      10                       ,
        user_id:     current_user.id          ,
        status:      "open"                   ,
        stm_status:  "closed"                 ,
        maturation: Time.now + 3.minutes      ,
      }
      key = "stm_bug_id" if params["stm_bug_id"]
      key = "stm_repo_id" if params["stm_repo_id"]
      id = params["stm_bug_id"] || params["stm_repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
