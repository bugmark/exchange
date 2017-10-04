module Core
  class BidsController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show]

    # bug_id (optional)
    def index
      @bug = @repo = nil
      @timestamp = Time.now.strftime("%H:%M:%S")
      case
        when bug_id = params["bug_id"]&.to_i
          @bug = Bug.find(bug_id)
          @bids = Bid.where(bug_id: bug_id)
        when repo_id = params["repo_id"]&.to_i
          @repo = Repo.find(repo_id)
          @bids = Bid.where(repo_id: repo_id)
        else
          @bids = Bid.all
      end
    end

    def show
      @bid = Bid.find(params["id"])
    end

    # bug_id or repo_id, type(forecast | reward)
    def new
      @bid = BidCmd::Create.new(new_opts(params))
    end

    # id (contract ID)
    def edit
      # @bid = RewardCmd::Take.find(params[:id], with_counterparty: current_user)
    end

    def create
      opts = params["bid_cmd_create"]
      @bid = BidCmd::Create.new(valid_params(opts))
      if @bid.save_event.project
        redirect_to("/bids/#{@bid.id}")
      else
        render 'bids/new'
      end
    end

    def update
      # opts = params["contract_cmd_take"]
      # @bid = RewardCmd::Take.find(opts["id"], with_counterparty: current_user)
      # if @bid.save_event.project
      #   redirect_to("/bids/#{@bid.id}")
      # else
      #   render 'bids/new'
      # end
    end

    private

    def valid_params(params)
      fields = Bid.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def new_opts(params)
      opts = {
        type: "Bid::#{params["type"]&.camelize || 'GitHub'}",
        price: 0.50,
        contract_maturation: Time.now + 3.minutes,
        user_id: current_user.id
      }
      key = "bug_id" if params["bug_id"]
      key = "repo_id" if params["repo_id"]
      id = params["bug_id"] || params["repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
