class ContractsController < ApplicationController

  def index
    @contracts = Contract.all
  end
end
