class AsksController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :resolve]

  # bug_id (optional)
  def index
    @bug = @repo = nil
    @timestamp = Time.now.strftime("%H:%M:%S")
    case
      when bug_id = params["bug_id"]&.to_i
        @bug       = Bug.find(bug_id)
        @asks = Ask.where(bug_id: bug_id)
      when repo_id = params["repo_id"]&.to_i
        @repo      = Repo.find(repo_id)
        @asks = Ask.where(repo_id: repo_id)
      else
        @asks = Ask.all
    end
  end

  def show
    @ask = Ask.find(params["id"])
  end

  # bug_id or repo_id, type(forecast | reward)
  def new
    @ask = AskCmd::Create.new(new_opts(params))
  end

  # id (contract ID)
  def edit
    # @ask = AskCmd::Take.find(params[:id], with_counterparty: current_user)
  end

  def create
    opts = params["ask_cmd_create"]
    @ask = AskCmd::Create.new(valid_params(opts))
    if @ask.save_event.project
      redirect_to("/asks/#{@ask.id}")
    else
      render 'asks/new'
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
    fields = Ask.attribute_names.map(&:to_sym)
    params.permit(fields)
  end

  def new_opts(params)
    opts = {
      type:                "Ask::#{params["type"]&.camelize || 'GitHub'}"    ,
      token_value:         10                                                ,
      contract_maturation: Time.now + 3.minutes                              ,
      user_id:             current_user.id
    }
    key  = "bug_id"  if params["bug_id"]
    key  = "repo_id" if params["repo_id"]
    id   = params["bug_id"] || params["repo_id"]
    opts.merge({key => id}).without_blanks
  end
end
