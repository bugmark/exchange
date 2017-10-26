class Amendment < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract, :optional => true

  has_many :positions
  has_many :offers
  has_one  :escrow

  def bid_positions
    positions.where(side: 'bid')
  end

  def ask_positions
    positions.where(side: 'ask')
  end

  def short_type
    type.split("::").last.downcase
  end
end

# == Schema Information
#
# Table name: amendments
#
#  id          :integer          not null, primary key
#  type        :string
#  sequence    :integer
#  contract_id :integer
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
