class Position < ApplicationRecord

  has_paper_trail

  before_validation :default_attributes
  before_validation :update_value

  belongs_to :offer       , optional:   true
  has_many   :offers_sell , class_name: "Offer"   , :foreign_key => :salable_position_id
  belongs_to :user                                , optional: true
  belongs_to :escrow                              , optional: true
  belongs_to :parent      , class_name: "Position", optional: true
  has_many   :children    , class_name: "Position"
  has_one    :contract    , :through => :escrow

  belongs_to :amendment, optional: true

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
  end

  # ----- INSTANCE METHODS -----

  def xtag
    "pos"
  end

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
#  id           :integer          not null, primary key
#  offer_id     :integer
#  user_id      :integer
#  amendment_id :integer
#  escrow_id    :integer
#  parent_id    :integer
#  volume       :integer
#  price        :float
#  value        :float
#  side         :string
#  exref        :string
#  uuref        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
