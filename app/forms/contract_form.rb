class ContractForm < ApplicationForm

  CONTRACT_FIELDS = Contract.attribute_names.map &:to_sym
  delegate *CONTRACT_FIELDS, :to => :contract

  attr_accessor *CONTRACT_FIELDS
  attr_accessor :contract

  # validates :repo_id, presence: true

  def initialize(args = {})
    super(args)
    @contract = Contract.new(args)
  end

  def save
    valid? ? contract.save : false
  end

  def valid?
    if super && contract.valid?
      true
    else
      contract.valid?
      contract.errors.each do |field, error|
        errors.add(field, error)
      end
      false
    end
  end

  def invalid?
    ! valid?
  end
end
