class Transaction
  attr_reader :contract, :publisher, :counterparty
  def initialize(contract)
    @contract  = contract
    @publisher = contract.publisher
  end

  def publish
    @

  end

  def take(counterparty)

  end
end