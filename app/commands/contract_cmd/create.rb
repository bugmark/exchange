module ContractCmd
  class Create < ApplicationCommand

    validate :unique_contract

    def initialize(args)
      add_event(:contract, Event::ContractCreated.new(contract_opts(args)))
    end

    private

    def contract_opts(args)
      cmd_opts.merge(args)
    end

    def unique_contract
      # if BugmTime.now < contract.maturation
      #   errors.add(:maturation, "contract has not matured")
      # end
    end
  end
end

