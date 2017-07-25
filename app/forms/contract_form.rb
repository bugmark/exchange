class ContractForm < ApplicationForm

  CONTRACT_FIELDS = Contract.attribute_names.map &:to_sym
  delegate *CONTRACT_FIELDS, :to => :contract

  attr_subobjects :contract

  # validates :repo_id, presence: true

  def initialize(args = {})
    # super(args)
    @contract = Contract.new(args)
  end
end
