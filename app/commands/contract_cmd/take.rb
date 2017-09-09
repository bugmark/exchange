# module ContractCmd
#   class Take < ApplicationCommand
#
#     attr_subobjects :contract, :counterparty
#     attr_delegate_fields :contract
#
#     validate :counterparty_funds
#
#     def self.find(contract_id, with_counterparty:)
#       instance = allocate
#       instance.contract = Contract.find(contract_id)
#       instance.contract.counterparty_id = with_counterparty.to_i
#       instance.counterparty = User.find(with_counterparty.to_i)
#       instance
#     end
#
#     def initialize(contract_id, with_counterparty:)
#       @contract = Contract.find(contract_id)
#       @contract.counterparty_id = with_counterparty.to_i
#       @counterparty = User.find(contract.counterparty_id)
#     end
#
#     def transact_before_project
#       contract.status = "taken"
#       counterparty.token_balance -= contract.token_value
#     end
#
#     private
#
#     def counterparty_funds
#       if counterparty.token_balance < contract.token_value
#         errors.add(:token_value, "not enough funds in user account")
#       end
#     end
#   end
# end
