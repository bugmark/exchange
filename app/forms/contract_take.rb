class ContractTake < ApplicationForm

  attr_subobjects      :contract, :counterparty
  attr_delegate_fields :contract

  validate :counterparty_funds

  def self.find(contract_id, with_counterparty:)
    instance                          = allocate
    instance.contract                 = Contract.find(contract_id)
    instance.contract.counterparty_id = with_counterparty.to_i
    instance.counterparty             = User.find(with_counterparty.to_i)
    instance
  end

  def initialize(contract_id, with_counterparty:)
    @contract                 = Contract.find(contract_id)
    @contract.counterparty_id = with_counterparty.to_i
    @counterparty             = User.find(contract.counterparty_id)
  end

  def transact_before_save
    contract.status                = "taken"
    counterparty.pokerbux_balance -= contract.currency_amount
  end

  private

  def counterparty_funds
    if counterparty.pokerbux_balance < contract.currency_amount
      errors.add(:currency_amount, "not enough funds in user account")
    end
  end
end
