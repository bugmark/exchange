class ContractForm < ApplicationForm

  CONTRACT_FIELDS = Contract.attribute_names.map &:to_sym
  delegate *CONTRACT_FIELDS, :to => :contract

  attr_accessor *CONTRACT_FIELDS
  attr_accessor :contract

  def initalize(args = {})
    super(args)
    @contract = Contract.new(args)
  end

end
