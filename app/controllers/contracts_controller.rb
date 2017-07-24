class ContractsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  # bug_id (optional)
  def index
    @bug = @repo = nil
    case
      when bug_id = params["bug_id"]&.to_i
        @bug       = Bug.find(bug_id)
        @contracts = Contract.where(bug_id: bug_id)
      when repo_id = params["repo_id"]&.to_i
        @repo      = Repo.find(repo_id)
        @contracts = Contract.where(repo_id: repo_id)
      else
        @contracts = Contract.all
    end
  end

  def show
    @contract = Contract.find(params["id"])
  end

  # bug_id or repo_id, type(forecast | reward)
  def new
    @contract = Contract.new(new_opts(params))
  end

  # id (contract ID)
  def edit
    @contract = Contract.find(params[:id])
    @contract.counterparty_id = current_user.id
  end

  def create
    opts = params["contract_forecast"] || params["contract_reward"]
    contract = Contract.create(valid_params(opts))
    redirect_to("/contracts/#{contract.id}")
  end

  def update
    opts = params["contract_forecast"] || params["contract_reward"]
    contract = Contract.find(opts["id"])
    contract.status = "taken"
    contract.counterparty_id = opts["counterparty_id"]
    contract.save
    redirect_to "/contracts"
  end

  private

  def valid_params(params)
    fields = %i(type terms bug_id repo_id currency_type currency_amount expire_at publisher_id)
    params.permit(fields)
  end

  def new_opts(params)
    opts = {
      type:            "Contract::#{params["type"]&.capitalize}"    ,
      terms:           "Net0"                                       ,
      currency_type:   "PokerBux"                                   ,
      currency_amount: 10                                           ,
      expire_at:       Time.now + 14.days                           ,
      publisher_id:    current_user.id
    }
    key  = "bug_id"  if params["bug_id"]
    key  = "repo_id" if params["repo_id"]
    id   = params["bug_id"] || params["repo_id"]
    opts.merge({key => id})
  end
end
