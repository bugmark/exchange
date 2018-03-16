class Escrow < ApplicationRecord

  has_paper_trail
  acts_as_list :column => :sequence, :scope => 'contract_uuid = \'#{contract_uuid}\''

  belongs_to :contract , optional: true, foreign_key: "contract_uuid" , primary_key: "uuid"
  belongs_to :amendment, optional: true, foreign_key: "amendment_uuid", primary_key: "uuid"

  has_many :positions                                        , class_name: "Position", primary_key: "uuid", foreign_key: "escrow_uuid"
  has_many :fixed_positions   , -> { where(side: 'fixed')   }, class_name: "Position", primary_key: "uuid", foreign_key: "escrow_uuid"
  has_many :unfixed_positions , -> { where(side: 'unfixed') }, class_name: "Position", primary_key: "uuid", foreign_key: "escrow_uuid"

  has_many :users, :through => :positions

  before_validation :update_values

  # ----- VALIDATIONS -----

  # validates :amendment_uuid, presence: true
  # validates :type          , presence: true

  # ----- SCOPES -----

  class << self
    def select_subset
      select(%i(id type sequence contract_uuid amendment_uuid fixed_value unfixed_value))
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

  def update_values
    self.fixed_value   = fixed_values
    self.unfixed_value = unfixed_values
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
#  id             :integer          not null, primary key
#  uuid           :string
#  exid           :string
#  type           :string
#  sequence       :integer
#  contract_uuid  :string
#  amendment_uuid :string
#  fixed_value    :float            default(0.0)
#  unfixed_value  :float            default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
