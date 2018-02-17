module ContractCmd
  class Cancel < ApplicationCommand

    attr_accessor :proto

    validate :existing_contract
    validate :open_contract
    validate :no_amendments

    def initialize(contract)
      @proto = Contract.find(contract.to_i)
      add_event :contract, Event::ContractCancelled.new(cancel_args)
    end

    private

    def cancel_args
      {
        uuid: proto.uuid
      }.merge(cmd_opts)
    end

    def existing_contract
      return true if proto.present?
      errors.add(:contract, "contract does not exist")
      false
    end

    def open_contract
      return true if proto.status == "open"
      errors.add(:contract, "contract not open")
      false
    end

    def no_amendments
      return true if proto.amendments.count == 0
      errors.add(:contract, "can not cancel contracts with amendments")
      false
    end
  end
end

