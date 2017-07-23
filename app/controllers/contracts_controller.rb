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

  # bug_id or repo_id
  def new
    @contract = Contract.new(type: 'Contract::Reward')
  end

  # id (contract ID)
  def edit
    @contract = Contract.find(params[:id])
  end
end
