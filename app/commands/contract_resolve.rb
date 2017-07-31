class ContractResolve < ApplicationCommand

  attr_subobjects      :contract, :publisher, :counterparty
  attr_delegate_fields :contract

  validates :counterparty_id,     presence: true
  validate  :resolvable_contract

  def self.find(contract_id)
    instance              = allocate
    instance.contract     = Contract.find(contract_id.to_i)
    instance.publisher    = instance.contract.publisher
    instance.counterparty = instance.contract.counterparty
    instance
  end

  def initialize(contract_id)
    @contract     = Contract.find(contract_id.to_i)
    @publisher    = contract.publisher
    @counterparty = contract.counterparty
  end

  def transact_before_save
    contract.status               = get_status
    contract.awarded_to           = contract.awardee
    awardee = contract.send(contract.awardee.to_sym)
    awardee.pokerbux_balance += contract.currency_amount * 2
  end

  private

  def get_status
    status = "lapsed"
    status = "resolved" if contract.counterparty.present?
    status
  end

  def resolvable_contract
    if Time.now > contract.matures_at
      errors.add(:matures_at, "contract has not matured")
    end
  end
end
