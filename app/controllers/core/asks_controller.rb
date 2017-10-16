module Core
  class AsksController < ApplicationController

    layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve]

    # bug_id (optional)
    def index
      @bug = @repo = nil
      @timestamp = Time.now.strftime("%H:%M:%S")
      case
        when bug_id = params["bug_id"]&.to_i
          @bug = Bug.find(bug_id)
          @asks = Ask.where(bug_id: bug_id)
        when repo_id = params["repo_id"]&.to_i
          @repo = Repo.find(repo_id)
          @asks = Ask.where(repo_id: repo_id)
        else
          @asks = Ask.all
      end
    end

    def show
      @ask = Offer::Buy::Ask.find(params["id"])
    end

    # bug_id or repo_id, type(forecast | reward)
    def new
      @ask = BuyAskCmd::Create.new(new_opts(params))
    end

    # id (contract ID)
    def edit
      # @ask = AskCmd::Take.find(params[:id], with_counterparty: current_user)
    end

    def create
      opts = params["buy_ask_cmd_create"]
      @ask = BuyAskCmd::Create.new(valid_params(opts))
      if @ask.save_event.project
        redirect_to("/core/asks/#{@ask.id}")
      else
        render 'core/asks/new'
      end
    end

    def update
      # opts = params["contract_cmd_take"]
      # @ask = AskCmd::Take.find(opts["id"], with_counterparty: current_user)
      # if @ask.save_event.project
      #   redirect_to("/asks/#{@ask.id}")
      # else
      #   render 'asks/new'
      # end
    end

    private

    def valid_params(params)
      fields = Offer::Buy::Ask.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def new_opts(params)
      opts = {
        price:      0.50                      ,
        volume:     5                         ,
        status:     "open"                    ,
        bug_status: "closed"                  ,
        maturation_date: Time.now + 3.minutes ,
        user_id: current_user.id
      }
      key = "bug_id" if params["bug_id"]
      key = "repo_id" if params["repo_id"]
      id = params["bug_id"] || params["repo_id"]
      opts.merge({key => id}).without_blanks
    end
  end
end
