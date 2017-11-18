module ContractCmd
  class Clone

    attr_reader :contract, :command

    delegate :project, :save_event, :valid?, :errors, :to => :command

    def initialize(contract, new_attrs)
      @contract = Contract.find(contract.to_i)
      @command  = ContractCmd::Create.new(valid_attrs(new_attrs))
    end

    private

    def valid_attrs(new_attrs)
      alt  = {protype_id: contract.id, status: "open"}
      contract.attributes.merge(alt).merge(new_attrs)
    end
  end
end

