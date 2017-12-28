module ContractCmd
  class Delete < ApplicationCommand

    # attr_subobjects :contract
    # attr_delegate_fields :contract

    validate :existing_contract
    validate :no_amendments

    def initialize(contract)
      @contract = Contract.find(contract.to_i)
    end

    private

    def existing_contract
      # if BugmTime.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end

    def no_amendments
      # if BugmTime.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end
  end
end

