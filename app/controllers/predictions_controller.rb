class PredictionsController < ApplicationController

  def index
    @contracts = Contract.extensible.unresolved
    @repo = false
    @bug  = false
  end
end