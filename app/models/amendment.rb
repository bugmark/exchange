class Amendment < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract, :optional => true

  has_many :offers
  has_one  :escrow

  has_many :positions
  has_many :bid_positions , -> { where(side: 'bid')}, class_name: "Position"
  has_many :ask_positions , -> { where(side: 'ask')}, class_name: "Position"

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
