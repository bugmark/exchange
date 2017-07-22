class ContractsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  def index
    @contracts = Contract.all
  end

  def new
  end

  def edit
  end
end
