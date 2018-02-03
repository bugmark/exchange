module ContractCmd
  class Resolve < ApplicationCommand

    attr_reader :contract

    validate :resolvable_contract

    def initialize(contract)
      @contract = Contract.find(contract.to_i)
    end

    def user_ids
      contract&.escrows&.reduce([]) do |acc, esc|
        acc + esc.users.pluck(:id)
      end.sort.uniq
    end

    def project
      contract.status = "resolved"
      contract.awarded_to = contract.awardee
      contract.save
      binding.pry
      contract.escrows.each do |escrow|
        poslist = contract.awarded_to == "fixed" ? escrow.fixed_positions : escrow.unfixed_positions
        psum  = poslist.map {|p| p.value}.sum
        poslist.each do |position|
          prorata = position.value / psum
          payout  = (position.escrow.total_value - position.value) * prorata
          new_bal = position.user.balance + payout
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
