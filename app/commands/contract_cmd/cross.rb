module ContractCmd
  class Cross < ApplicationCommand

    attr_subobjects :contract, :ask
    attr_reader :cross_list
    attr_delegate_fields :contract

    validate :cross_integrity

    def initialize(ask)
      @ask = Ask.where(contract_id: nil).find(ask.to_i)
      @contract = Contract.new
      @cross_list = bin_pack(ask.token_value, ask&.cross_list)
    end

    def transact_before_project
      contract.save
      ask.contract_id = contract.id
      cross_list.each { |bid| bid.update_attributes(contract_id: contract.id) }
    end

    private

    # Combine bids and asks to form a contract.
    # TODO: Review/optimize this implementation
    # See:
    # https://en.wikipedia.org/wiki/Bin_packing_problem
    # https://en.wikipedia.org/wiki/Knapsack_problem
    def bin_pack(target_price, bid_list = [])
      sorted_bids = bid_list.to_a.sort_by { |bid| bid.token_value }
      rtotal, rlist = sorted_bids.reduce([0, []]) do |(acc, list), bid|
        acc, list = [acc + bid.token_value, list << bid] if acc < target_price
        [acc, list]
      end
      rtotal >= target_price ? rlist : []
    end

    def cross_integrity
      # TODO: check balances on both sides of the cross to ensure they are valid
      if @cross_list.length == 0
        errors.add :id, "no crosses found"
      end
      if @ask.nil?
        errors.add :id, "invalid ask"
      end
    end
  end
end

