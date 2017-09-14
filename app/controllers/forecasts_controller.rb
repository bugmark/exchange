class ForecastsController < ApplicationController

  def index
    @contracts = Contract.forecast.unresolved
    @repo = false
    @bug  = false
  end
end