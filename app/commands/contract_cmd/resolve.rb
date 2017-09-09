module ContractCmd
  class Resolve < ApplicationCommand

    attr_subobjects :contract
    attr_accessor :bids, :asks
    attr_delegate_fields :contract

    validate :resolvable_contract

    def self.find(contract)
      instance = allocate
      instance.contract = Contract.find(contract.to_i)
      instance.bids     = instance.contract.bids
      instance.asks     = instance.contract.asks
      instance
    end

    def initialize(contract)
      @contract = Contract.find(contract.to_i)
      @bids     = @contract.bids
      @asks     = @contract.asks
    end

    def transact_before_project
      contract.status = "resolved"
      contract.awarded_to = contract.awardee
      if contract.awarded_to == "asker"
        # TODO: use a command!
        asker = contacts.asks.first.user
        asker.token_balance += contract.distribution_tokens
      else
        # TODO: use a command!
        # TODO: devise a more consistent way to save sub-objects...
        contract.bidder_allocation.each do |bid_id, allocation|
          usr = Bid.find(bid_id).user
          usr.update_attribute(:token_balance, usr.token_balance + allocation)
        end
      end
    end

    private

    def resolvable_contract
      if Time.now < contract.contract_maturation
        errors.add(:contract_maturation, "contract has not matured")
      end
    end
  end
end

