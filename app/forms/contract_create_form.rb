class ContractCreateForm < ApplicationForm

  attr_subobjects      :contract, :user
  attr_delegate_fields :contract

  validate :user_funds

  def initialize(args = {})
    @contract = Contract.new(args)
    @user     = User.find(contract.publisher_id)
  end

  def form_transaction
    user.pokerbux_balance -= contract.currency_amount
  end

  private

  def user_funds
    if user.pokerbux_balance < contract.currency_amount
      errors.add(:currency_amount, "not enough funds in user account")
    end
  end
end
