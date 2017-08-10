module Command
  class ContractResolve < ApplicationCommand

    attr_subobjects :contract, :publisher
    attr_accessor :counterparty
    attr_delegate_fields :contract

    validate :resolvable_contract

    def self.find(contract)
      instance = allocate
      instance.contract = Contract.find(contract.to_i)
      instance.publisher = instance.contract.publisher
      instance.counterparty = instance.contract.counterparty
      instance
    end

    def initialize(contract)
      @contract = Contract.find(contract.to_i)
      @publisher = @contract.publisher
      @counterparty = @contract.counterparty
    end

    def transact_before_save
      contract.status = get_status
      if contract.status == "lapsed"
        contract.awarded_to = "publisher"
        contract.publisher.token_balance += contract.token_value
      else
        contract.awarded_to = contract.awardee
        awardee = contract.send(contract.awardee.to_sym)
        awardee.token_balance += contract.token_value * 2
      end
    end

    private

    def get_status
      status = "lapsed"
      status = "awarded" if contract.counterparty.present?
      status
    end

    def resolvable_contract
      if Time.now < contract.matures_at
        errors.add(:matures_at, "contract has not matured")
      end
    end
  end
end
