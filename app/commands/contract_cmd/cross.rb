module ContractCmd
  class Cross < ApplicationCommand

    attr_subobjects :contract, :ask
    attr_reader :cross_list
    attr_delegate_fields :contract

    validate :cross_integrity

    def initialize(ask)
      # TODO: check that ask.contract_id is null
      @ask        = Ask.find(ask.to_i)
      @contract   = Contract.new
      @cross_list = ask.cross_list  # TODO: make sure that all bids have null contract ids
    end

    def transact_before_project
      contract.save
      ask.contract_id = contract.id
      cross_list.each {|bid| bid.update_attributes(contract_id: contract.id)}
    end

    private

    def cross_integrity
      # TODO: check balances on both sides of the cross to ensure they are valid
      if @cross_list.length == 0
        errors.add :id, "no crosses found"
      end
    end
  end
end

