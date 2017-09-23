module Core
  class ForecastsController < ApplicationController

  layout 'core'

  def index
    @contracts = Contract.forecast.unresolved
    @repo = false
    @bug  = false
  end
  end
end
