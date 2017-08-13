module ContractCmd
  class Pub < ApplicationCommand

    attr_subobjects :contract, :user
    attr_delegate_fields :contract

    validate :publisher_funds

    def initialize(args = {})
      @contract = Contract.new(args)
      @user = User.find(contract.publisher_id)
    end

    def event_data
      {}
    end

    def transact_before_project
      contract.status = "open"
      user.token_balance -= contract.token_value
    end

    private

    def publisher_funds
      if user.token_balance < contract.token_value
        errors.add(:token_value, "not enough funds in user account")
      end
    end
  end
end
