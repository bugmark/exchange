class ContractsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  def index
    @contracts = Contract.all
  end

  def new
    binding.pry
    @contract = Contract.new
  end

  def edit
    binding.pry
    x = 1
  end
end
