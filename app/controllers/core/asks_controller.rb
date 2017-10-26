module Core
  class AsksController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve]

    def index
      @bug = @repo = nil
      @timestamp = Time.now.strftime("%H:%M:%S")
      case
        when bug_id = params["bug_id"]&.to_i
          @bug = Bug.find(bug_id)
          @asks = Offer::Buy::Ask.where(bug_id: bug_id)
        when stm_repo_id = params["stm_repo_id"]&.to_i
          @repo = Repo.find(stm_repo_id)
          @asks = Offer::Buy::Ask.where(stm_repo_id: stm_repo_id)
        else
          @asks = Offer::Buy::Ask.all
      end
    end

    def new
      @ask = OfferCmd::CreateBuy.new(:ask, new_opts(params))
    end

    def create
      opts = params["offer_cmd_create_buy"]
      @ask = OfferCmd::CreateBuy.new(:ask, new_opts.merge(valid_params(opts)))
      if @ask.save_event.project
        redirect_to("/core/offers/#{@ask.id}")
      else
        render 'core/asks/new'
      end
    end

    private

    def valid_params(params)
      fields = Offer::Buy::Ask.attribute_names.map(&:to_sym)
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
        maturation: Time.now + 3.minutes      ,
        user_id: current_user.id
      }
      key = "stm_bug_id" if params["stm_bug_id"]
      key = "stm_repo_id" if params["stm_repo_id"]
      id = params["stm_bug_id"] || params["stm_repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
