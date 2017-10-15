class Position < ApplicationRecord

  has_paper_trail

  has_one    :buy_offer   , class_name: "Offer"
  has_many   :sell_offers , class_name: "Offer"
  belongs_to :parent      , class_name: "Position" , optional: true
  has_many   :children    , class_name: "Escrow"

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
