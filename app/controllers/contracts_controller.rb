class ContractsController < ApplicationController

  def index
    @contracts = Contract.all
  end

  def new

  end

  def edit
  end
end
