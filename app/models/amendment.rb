class Amendment < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract, :optional => true

  has_many :offers
  has_one  :escrow
  has_many :positions

  def short_type
    type.split("::").last.downcase
  end

  # ----- SCOPES -----

  class << self
    def select_subset
      select(%i(id type sequence contract_id))
    end
    alias_method :ss, :select_subset
  end

  # ----- INSTANCE METHODS -----
  def dumptree
    dt_hdr
    dump
    escrow.dump
    puts ">>>>> OFFERS"
    offers.each { |pos| pos.dumptree}
    puts ">>>>> POSITIONS"
    unfixed_positions.each { |pos| pos.dumptree}
    dt_ftr("amendment #{self.id}")
  end
  alias_method :dt, :dumptree
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
