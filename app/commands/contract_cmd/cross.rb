module ContractCmd
  class Cross < ApplicationCommand

    attr_subobjects :contract, :ask
    attr_reader :cross
    attr_delegate_fields :contract

    validate :cross_integrity

    def initialize(bid)
      @bid      = Bid.find(bid.to_i)
      @contract = Contract.new
      @cross    = bid.cross
    end

    def transact_before_project
      contract.save
      ask.contract_id = contract.id
      cross.each {|bid| bid.update_attributes(contract_id: contract.id)}
    end

    private

    def cross_integrity
      if @cross.length == 0
        errors.add :id, "no crosses found"
      end
    end
  end
end

