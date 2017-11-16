module ContractCmd
  class Create < ApplicationCommand

    attr_subobjects :contract
    attr_delegate_fields :contract

    validate :unique_contract

    def initialize(terms)
      @contract = Contract.new(contract.to_i)
    end

    def transact_before_project
    end

    private

    def unique_contract
      # if Time.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end
  end
end

