module ContractCmd
  class Resolve < ApplicationCommand

    attr_reader :base_contract

    validate :resolvable_contract

    def initialize(contract)
      @base_contract = Contract.find(contract.to_i)
      add_event(:contract, Event::ContractResolved.new(con_opts(@base_contract)))
      resolve_escrows
    end

    def user_ids
      contract&.escrows&.reduce([]) do |acc, esc|
        acc + esc.users.pluck(:id)
      end.sort.uniq
    end

    def resolve_escrows
      base_contract.escrows.each_with_index do |escrow, idxe|
        poslst = base_contract.awardee == "fixed" ? escrow.positions.fixed.leaf : escrow.positions.unfixed.leaf
        escvol = poslst.map {|p| p.volume}.sum
        poslst.each_with_index do |position, idxp|
          prorata = escvol / position.volume.to_f
          payout  = escrow.total_value * prorata
          add_event("esc_#{idxe}_#{idxp}", Event::EscrowDistributed.new(base_opts({uuid: escrow.uuid})))
          add_event("usr_#{idxe}_#{idxp}", Event::UserCredited.new(base_opts({uuid: position.user.uuid, amount: payout})))
        end
      end
    end

    private

    def con_opts(contract)
      cmd_opts.merge({uuid: contract.uuid})
    end

    def base_opts(input)
      cmd_opts.merge(input)
    end

    def resolvable_contract
      if BugmTime.now < base_contract.maturation
        errors.add(:maturation, "contract has not matured")
      end
    end
  end
end
