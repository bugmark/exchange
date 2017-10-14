class Position < ApplicationRecord

  # belongs_to :contract     , optional: true
  # belongs_to :parent_escrow, class_name: "Escrow", foreign_key: "parent_id", optional: true
  # has_one    :child_escrow , class_name: "Escrow", foreign_key: "parent_id"
  #
  # has_many   :positions
  # has_many   :bid_positions , -> { where(side: 'bid') }, class_name: "Position"
  # has_many   :ask_positions , -> { where(side: 'ask') }, class_name: "Position"
  #
  #
  # belongs_to :offer
  # has_one    :buy_offer      , class_name: "Offer"
  # has_many   :sell_offers    , class_name: "Offer"
  # belongs_to :parent_position, class_name: "Escrow"
  # has_one    :child_escrow,  class_name: "Escrow"
  #
  # has_many   :positions
  # has_many   :fixed_positions
  # has_many   :unfixed_positions
  #
  # has_many   :fixed_offers
  # has_many   :unfixed_offers

end

# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  offer_id   :integer
#  escrow_id  :integer
#  parent_id  :integer
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
