module Event
  class ContractPub < ApplicationEvent

    attr_accessor :type, :publisher_uuid, :token_value, :repo_id, :bug_id, :bug_title, :uuref

    class << self

      def self.find(contract)
        instance = allocate
        instance.contract = Contract.find(contract.to_i)
        instance.publisher = instance.contract.publisher
        instance.counterparty = instance.contract.counterparty
        instance
      end

      def from_command(command)
        instance = allocate

      end

      def from_data(data)

      end

      def append

      end

    end

    def project

    end

  end
end