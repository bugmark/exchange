module ContractCmd
  class Resolve < ApplicationCommand

    attr_subobjects      :contract
    attr_delegate_fields :contract

    validate :resolvable_contract

    def initialize(contract)
      @contract = Contract.find(contract.to_i)
    end

    def event_data
      contract&.attributes
    end

    def user_ids
      contract&.escrows&.reduce([]) do |acc, esc|
        acc + esc.users.pluck(:id)
      end.sort.uniq
    end

    def transact_before_project
      contract.status = "resolved"
      contract.awarded_to = contract.awardee
      contract.escrows.each do |escrow|
        poslist = contract.awarded_to == "fixed" ? escrow.fixed_positions : escrow.unfixed_positions
        poslist.each do |position|
          new_bal = position.user.balance + position.value
          position.user.update_attribute(:balance, new_bal)
        end
      end
    end

    private

    def resolvable_contract
      if BugmTime.now < contract.maturation
        errors.add(:maturation, "contract has not matured")
      end
    end
  end
end
