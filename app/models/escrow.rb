class Escrow < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract , optional: true
  belongs_to :amendment, optional: true

  has_many   :positions
  has_many   :fixed_positions   , -> { where(side: 'fixed')   }, class_name: "Position"
  has_many   :unfixed_positions , -> { where(side: 'unfixed') }, class_name: "Position"

  # ----- VALIDATIONS -----

  validates :amendment_id, presence: true
  validates :type        , presence: true

  # ----- SCOPES -----

  class << self
    def select_subset
      select(%i(id type sequence contract_id amendment_id fixed_value unfixed_value))
    end
    alias_method :ss, :select_subset
  end

  # ----- INSTANCE METHODS -----

  def total_value
    fixed_value + unfixed_value
  end
  alias_method :value, :total_value

  def fixed_values
    fixed_positions.map(&:value).sum
  end

  def unfixed_values
    unfixed_positions.map(&:value).sum
  end

  def dumptree
    dt_hdr
    dump
    puts ">>>>> FIXED POSITIONS"
    fixed_positions.each { |pos| pos.dumptree}
    puts ">>>>> UNFIXED POSITIONS"
    unfixed_positions.each { |pos| pos.dumptree}
    dt_ftr("escrow #{self.id}")
  end
  alias_method :dt, :dumptree
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
