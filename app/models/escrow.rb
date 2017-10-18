class Escrow < ApplicationRecord

  has_paper_trail

  belongs_to :contract , optional: true
  belongs_to :parent   , class_name: "Escrow", foreign_key: "parent_id", optional: true
  has_one    :child    , class_name: "Escrow", foreign_key: "parent_id"

  has_many   :positions
  has_many   :bid_positions , -> { where(side: 'bid') }, class_name: "Position"
  has_many   :ask_positions , -> { where(side: 'ask') }, class_name: "Position"

  def set_association(contract)
    if tail = contract.escrow_tail
      self.parent_id = tail.id
    else
      self.contract_id = contract.id
    end
    self
  end

  # has_many   :fixed_offers
  # has_many   :unfixed_offers

end

# == Schema Information
#
# Table name: escrows
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  parent_id   :integer
#  bid_value   :float            default(0.0)
#  ask_value   :float            default(0.0)
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
