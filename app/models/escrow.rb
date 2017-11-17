class Escrow < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract , optional: true
  belongs_to :amendment, optional: true

  has_many   :positions
  has_many   :fixed_positions   , -> { where(side: 'fixed')   }, class_name: "Position"
  has_many   :unfixed_positions , -> { where(side: 'unfixed') }, class_name: "Position"

  # ----- INSTANCE METHODS -----

  def total_value
    fixed_value + unfixed_value
  end

  def fixed_values
    fixed_positions.map(&:value).sum
  end

  def unfixed_values
    unfixed_positions.map(&:value).sum
  end
end

# == Schema Information
#
# Table name: escrows
#
#  id            :integer          not null, primary key
#  type          :string
#  sequence      :integer
#  contract_id   :integer
#  amendment_id  :integer
#  fixed_value   :float            default(0.0)
#  unfixed_value :float            default(0.0)
#  exref         :string
#  uuref         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
