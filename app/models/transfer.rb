class Transfer < ApplicationRecord

  has_paper_trail

  belongs_to :sell_offer      , class_name: "Offer"   , :optional => true, :foreign_key => :sell_offer_id
  belongs_to :buy_offer       , class_name: "Offer"   , :optional => true, :foreign_key => :buy_offer_id
  belongs_to :parent_position , class_name: "Position", :optional => true, :foreign_key => :parent_position_id
  belongs_to :seller_position , class_name: "Position", :optional => true, :foreign_key => :seller_position_id
  belongs_to :buyer_position  , class_name: "Position", :optional => true, :foreign_key => :buyer_position_id

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
#  exref              :string
#  uuref              :string
#
