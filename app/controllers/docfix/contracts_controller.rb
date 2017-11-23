module Docfix
  class ContractsController < ApplicationController

    layout 'docfix'

    def index
      @query     = ContractQuery.new
      @contracts = Contract.paginate(page: params[:page], per_page: 5)
    end

    def show
      @contract = Contract.find(params[:id])
    end
  end
end

