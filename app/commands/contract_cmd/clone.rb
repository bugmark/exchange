module ContractCmd
  class Clone < ApplicationCommand

    attr_subobjects :contract
    attr_delegate_fields :contract

    validate :existing_contract
    validate :unique_contract

    def initialize(contract, terms)
      @old_contract = Contract.find(contract.to_i)
      @contract = Contract.new(@old_contract.attributes.merge(terms))
    end

    def transact_before_project
    end

    private

    def existing_contract
      # if Time.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end

    def unique_contract
      # if Time.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end
  end
end

