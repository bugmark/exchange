class ContractPub < ApplicationCommand

  attr_subobjects      :contract, :user
  attr_delegate_fields :contract

  validate :publisher_funds

  def initialize(args = {})
    @contract = Contract.new(args)
    @user     = User.find(contract.publisher_id)
  end

  def transact_before_save
    contract.status        = "open"
    user.pokerbux_balance -= contract.currency_amount
  end

  private

  def publisher_funds
    if user.pokerbux_balance < contract.currency_amount
      errors.add(:currency_amount, "not enough funds in user account")
    end
  end
end
