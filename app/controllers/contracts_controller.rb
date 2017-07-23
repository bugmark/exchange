class ContractsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  # bug_id (optional)
  def index
    if bug_id = params["bug_id"]&.to_i
      @bug       = Bug.find(bug_id)
      @contracts = Contract.where(bug_id: bug_id)
    else
      @bug       = nil
      @contracts = Contract.all
    end
  end

  # bug_id or repo_id, type(forecast | reward)
  def new
    @contract = Contract.new(new_opts(params))
  end

  # id (contract ID)
  def edit
    @contract = Contract.find(params[:id])
  end

  def create
    binding.pry
    xx = 1
  end

  def show
    @contract = Contract.find(params["id"])
  end

  private

  def new_opts(params)
    opts = {type: "Contract::#{params["type"]&.capitalize}"}
    key  = "bug_id"  if params["bug_id"]
    key  = "repo_id" if params["repo_id"]
    id   = params["bug_id"] || params["repo_id"]
    opts.merge({key => id, 'publisher_id' => current_user.id})
  end
end
