class Position < ApplicationRecord

  has_paper_trail

  def xtag
    "pos"
  end

  belongs_to :buy_offer      , class_name: "Offer"   , optional: true, :foreign_key => :buy_offer_id
  has_many   :sell_offers    , class_name: "Offer"                   , :foreign_key => :parent_position_id
  belongs_to :user                                   , optional: true
  belongs_to :escrow                                 , optional: true
  belongs_to :parent         , class_name: "Position", optional: true
  has_many   :children       , class_name: "Position"
  has_one    :contract       , :through => :escrow

  # belongs_to :child_transfer , class_name: "Transfer"
  # belongs_to :parent_transfer, class_name: "Transfer"

  # ----- INSTANCE METHODS -----

end

# == Schema Information
#
# Table name: positions
#
#  id           :integer          not null, primary key
#  buy_offer_id :integer
#  user_id      :integer
#  escrow_id    :integer
#  parent_id    :integer
#  volume       :integer
#  price        :float
#  side         :string
#  exref        :string
#  uuref        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
