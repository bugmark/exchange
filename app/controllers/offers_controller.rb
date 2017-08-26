class OffersController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :resolve]

  # bug_id (optional)
  def index
    # @bug = @repo = nil
    # @timestamp = Time.now.strftime("%H:%M:%S")
    # case
    #   when bug_id = params["bug_id"]&.to_i
    #     @bug       = Bug.find(bug_id)
    #     @contracts = Contract.where(bug_id: bug_id)
    #   when repo_id = params["repo_id"]&.to_i
    #     @repo      = Repo.find(repo_id)
    #     @contracts = Contract.where(repo_id: repo_id)
    #   else
    #     @contracts = Contract.all
    # end
  end

  def show
    # @contract = Contract.find(params["id"])
  end

  # bug_id or repo_id, type(forecast | reward)
  def new
    # @contract = ContractCmd::Publish.new(new_opts(params))
  end

  # id (contract ID)
  def edit
    # @contract = ContractCmd::Take.find(params[:id], with_counterparty: current_user)
  end

  def create
    # opts = params["contract_cmd_publish"]
    # @contract = ContractCmd::Publish.new(valid_params(opts))
    # if @contract.save_event.project
    #   redirect_to("/contracts/#{@contract.id}")
    # else
    #   render 'contracts/new'
    # end
  end

  def update
    # opts = params["contract_cmd_take"]
    # @contract = ContractCmd::Take.find(opts["id"], with_counterparty: current_user)
    # if @contract.save_event.project
    #   redirect_to("/contracts/#{@contract.id}")
    # else
    #   render 'contracts/new'
    # end
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
      token_value:     10                                           ,
      matures_at:      Time.now + 3.minutes                         ,
      publisher_id:    current_user.id
    }
    key  = "bug_id"  if params["bug_id"]
    key  = "repo_id" if params["repo_id"]
    id   = params["bug_id"] || params["repo_id"]
    opts.merge({key => id})
  end
end
