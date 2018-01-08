module ContractCmd
  class Create < ApplicationCommand

    # attr_subobjects :contract
    # attr_delegate_fields :contract

    validate :unique_contract

    def initialize(terms)
      @contract = Contract.new(contract.to_i)
    end

    private

    def unique_contract
      # if BugmTime.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end
  end
end

