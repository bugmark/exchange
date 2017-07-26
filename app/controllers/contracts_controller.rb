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
    @contract = ContractPub.new(new_opts(params))
  end

  # id (contract ID)
  def edit
    @contract = ContractTake.find(params[:id], with_counterparty: current_user)
  end

  def create
    binding.pry
    opts = params["contract_pub"]
    @contract = ContractPub.new(valid_params(opts))
    if @contract.save
      redirect_to("/contracts/#{@contract.id}")
    else
      render 'contracts/new'
    end
  end

  def update
    binding.pry
    opts = params["contract_take"]
    @contract = ContractTake.find(opts["id"], with_counterparty: current_user)
    if @contract.save
      redirect_to("/contracts/#{@contract.id}")
    else
      render 'contracts/new'
    end
  end

  private

  def valid_params(params)
    fields = Contract.attribute_names.map(&:to_sym)
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
