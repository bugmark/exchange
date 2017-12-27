class Position < ApplicationRecord

  has_paper_trail

  before_validation :default_attributes
  before_validation :update_value

  belongs_to :offer       , optional:   true      , foreign_key: "offer_uuid", primary_key: "uuid"
  has_many   :offers_sell , class_name: "Offer"   , foreign_key: "salable_position_id"
  belongs_to :user        , optional: true        , foreign_key: "user_uuid" , primary_key: "uuid"
  belongs_to :escrow                              , optional: true
  belongs_to :parent      , class_name: "Position", optional: true
  has_many   :children    , class_name: "Position"
  has_one    :contract    , :through => :escrow

  belongs_to :amendment, optional: true, foreign_key: "amendment_uuid", primary_key: "uuid"

  # ----- VALIDATIONS -----

  validates :side, inclusion:    {in: %w(fixed unfixed) }

  # ----- SCOPES -----

  class << self
    def fixed
      where(side: 'fixed')
    end

    def unfixed
      where(side: 'unfixed')
    end

    def select_subset
      select(%i(id offer_id user_id amendment_id escrow_id parent_id volume price value side))
    end
    alias_method :ss, :select_subset
  end

  # ----- INSTANCE METHODS -----

  def xtag
    "pos" #
  end

  def dumptree
    dt_hdr
    dump
    offer.dumptree
    user.dumptree
    dt_ftr("position #{self.id}")
  end
  alias_method :dt, :dumptree

  private

  def default_attributes
    self.side ||= offer&.side
  end

  def update_value
    return unless self.volume && self.price
    self.value = self.volume * self.price
  end
end

# == Schema Information
#
# Table name: positions
#
#  id             :integer          not null, primary key
#  offer_id       :integer
#  offer_uuid     :string
#  user_id        :integer
#  user_uuid      :string
#  amendment_id   :integer
#  amendment_uuid :string
#  escrow_id      :integer
#  escrow_uuid    :string
#  parent_id      :integer
#  parent_uuid    :string
#  volume         :integer
#  price          :float
#  value          :float
#  side           :string
#  exid           :string
#  uuid           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
