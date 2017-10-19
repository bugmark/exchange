class Transfer < ApplicationRecord

  has_paper_trail

  # belongs_to :buy_offer      , class_name: "Offer"   , optional: true, :foreign_key => :offer_id
  # has_many   :sell_offers    , class_name: "Offer"
  # belongs_to :user                                   , optional: true
  # belongs_to :escrow                                 , optional: true
  # belongs_to :parent         , class_name: "Position", optional: true
  # has_many   :children       , class_name: "Position"
  # belongs_to :child_transfer , class_name: "Transfer"
  # belongs_to :parent_transfer, class_name: "Transfer"




  # ----- INSTANCE METHODS -----

end

# == Schema Information
#
# Table name: transfers
#
#  id                 :integer          not null, primary key
#  sell_offer_id      :integer
#  buy_offer_id       :integer
#  parent_position_id :integer
#  seller_position_id :integer
#  buyer_position_id  :integer
#
