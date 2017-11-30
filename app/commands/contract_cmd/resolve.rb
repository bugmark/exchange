module ContractCmd
  class Resolve < ApplicationCommand

    attr_subobjects :contract
    attr_delegate_fields :contract

    validate :resolvable_contract

    def initialize(contract)
      @contract = Contract.find(contract.to_i)
    end

    def transact_before_project
      # TODO: use a command!
      contract.status = "resolved"
      contract.awarded_to = contract.awardee
      contract.escrows.each do |escrow|
        poslist = contract.awarded_to == "asker" ? escrow.ask_positions : escrow.bid_positions
        poslist.each do |position|
          new_bal = position.user.balance + position.value
          position.user.update_attribute(:balance, new_bal)
        end
      end
    end

    private

    def resolvable_contract
      if Time.now < contract.maturation
        errors.add(:maturation, "contract has not matured")
      end
    end
  end
end
