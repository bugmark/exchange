class Position < ApplicationRecord

  has_paper_trail

  belongs_to :buy_offer   , class_name: "Offer"   , :foreign_key => :offer_id , optional: true
  has_many   :sell_offers , class_name: "Offer"
  belongs_to :user                                , optional: true
  belongs_to :escrow                              , optional: true
  belongs_to :parent      , class_name: "Position", optional: true
  has_many   :children    , class_name: "Position"

  # ----- INSTANCE METHODS -----

end

# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  offer_id   :integer
#  user_id    :integer
#  escrow_id  :integer
#  parent_id  :integer
#  volume     :integer
#  price      :float
#  side       :string
#  exref      :string
#  uuref      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
