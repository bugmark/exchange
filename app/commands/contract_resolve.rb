class ContractResolve < ApplicationCommand

  attr_subobjects      :contract, :publisher, :counterparty
  attr_delegate_fields :contract

  validate :resolvable_contract

  def self.find(contract_id)
    instance              = allocate
    instance.contract     = Contract.find(contract_id)
    instance.publisher    = instance.contract.publisher
    instance.counterparty = instance.contract.counterparty
    instance
  end

  def initialize(contract_id)
    @contract     = Contract.find(contract_id)
    @publisher    = contract.publisher
    @counterparty = contract.counterparty
  end

  def transact_before_save
    contract.status               = "resolved"
    contract.awarded_to           = contract.awardee
    # FIXME
    # contract.send(contract.awardee.to_sym).currency_amount += contract.currency_amount * 2
  end

  private

  def resolvable_contract
    if Time.now > contract.expires_at
      errors.add(:expires_at, "contract has not expired")
    end
  end
end
