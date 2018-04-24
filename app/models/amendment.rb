class Amendment < ApplicationRecord

  acts_as_list :column => :sequence, :scope => 'contract_uuid = \'#{contract_uuid}\''

  belongs_to :contract, :optional => true, foreign_key: "contract_uuid", primary_key: "uuid"

  has_many :offers    , foreign_key: "amendment_uuid", primary_key: "uuid"
  has_one  :escrow    , foreign_key: "amendment_uuid", primary_key: "uuid"
  has_many :positions , foreign_key: "amendment_uuid", primary_key: "uuid"

  def short_type
    type.split("::").last.downcase
  end

  # ----- SCOPES -----

  class << self
    def select_subset
      select(%i(id type sequence contract_uuid))
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
#  id            :integer          not null, primary key
#  uuid          :string
#  exid          :string
#  type          :string
#  sequence      :integer
#  contract_uuid :string
#  xfields       :hstore           not null
#  jfields       :jsonb            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
