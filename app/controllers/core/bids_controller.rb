module Core
  class BidsController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    # bug_id (optional)
    def index
      @bug = @repo = nil
      @timestamp = Time.now.strftime("%H:%M:%S")
      case
        when stm_bug_id = params["stm_bug_id"]&.to_i
          @bug = Bug.find(stm_bug_id)
          @bids = Offer::Buy::Bid.where(stm_bug_id: stm_bug_id)
        when stm_repo_id = params["stm_repo_id"]&.to_i
          @repo = Repo.find(stm_repo_id)
          @bids = Offer::Buy::Bid.where(stm_repo_id: stm_repo_id)
        else
          @bids = Offer::Buy::Bid.all
      end
    end

    def show
      @bid = Offer::Buy::Bid.find(params["id"])
    end

    def new
      @bid = OfferCmd::CreateBuy.new(:bid, new_opts(params))
    end

    # id (contract ID)
    def edit
      # @bid = ContractCmd::Take.find(params[:id], with_counterparty: current_user)
    end

    def create
      opts = params["offer_cmd_create_buy"]
      @bid = OfferCmd::CreateBuy.new(:bid, valid_params(opts))
      if @bid.save_event.project
        redirect_to("/core/bids/#{@bid.id}")
      else
        render 'core/bids/new'
      end
    end

    def update
      # opts = params["contract_cmd_take"]
      # @bid = ContractCmd::Take.find(opts["id"], with_counterparty: current_user)
      # if @bid.save_event.project
      #   redirect_to("/bids/#{@bid.id}")
      # else
      #   render 'bids/new'
      # end
    end

    private

    def valid_params(params)
      fields = Offer::Buy::Bid.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def new_opts(params)
      opts = {
        price:       0.50                     ,
        volume:      5                        ,
        user_id:     current_user.id          ,
        status:      "open"                   ,
        stm_status:  "closed"                 ,
        maturation: Time.now + 3.minutes ,
      }
      key = "stm_bug_id" if params["stm_bug_id"]
      key = "stm_repo_id" if params["stm_repo_id"]
      id = params["stm_bug_id"] || params["stm_repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
