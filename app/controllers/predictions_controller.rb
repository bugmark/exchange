class PredictionsController < ApplicationController

  def index
    @contracts = Contract.dynamic.unresolved
  end
end