class ContractTake < ApplicationForm

  attr_subobjects      :contract, :user
  attr_delegate_fields :contract

  validate :counterparty_funds

  def self.find(contract_id, with_counterparty:)
    instance                          = allocate
    instance.contract                 = Contract.find(contract_id)
    instance.contract.counterparty_id = with_counterparty.to_i
    instance.user = User.find(with_counterparty.to_i)
    instance
  end

  def initialize(args = {})
    @contract = Contract.new(args)
    @user     = User.find(contract.publisher_id)
  end

  def form_transaction
    contract.status        = "taken"
    user.pokerbux_balance -= contract.currency_amount
  end

  private

  def counterparty_funds
    if user.pokerbux_balance < contract.currency_amount
      errors.add(:currency_amount, "not enough funds in user account")
    end
  end
end
