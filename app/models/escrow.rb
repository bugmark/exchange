class Escrow < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract, optional: true

  has_many   :positions
  has_many   :bid_positions , -> { where(side: 'bid') }, class_name: "Position"
  has_many   :ask_positions , -> { where(side: 'ask') }, class_name: "Position"

end

# == Schema Information
#
# Table name: escrows
#
#  id          :integer          not null, primary key
#  sequence    :integer
#  contract_id :integer
#  bid_value   :float            default(0.0)
#  ask_value   :float            default(0.0)
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
