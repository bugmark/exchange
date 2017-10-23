class Amendment::Resolve < Amendment

  # belongs_to :sell_offer      , class_name: "Offer"   , :optional => true, :foreign_key => :sell_offer_id
  # belongs_to :buy_offer       , class_name: "Offer"   , :optional => true, :foreign_key => :buy_offer_id
  # belongs_to :parent_position , class_name: "Position", :optional => true, :foreign_key => :parent_position_id
  # belongs_to :seller_position , class_name: "Position", :optional => true, :foreign_key => :seller_position_id
  # belongs_to :buyer_position  , class_name: "Position", :optional => true, :foreign_key => :buyer_position_id

end

# == Schema Information
#
# Table name: amendments
#
#  id                     :integer          not null, primary key
#  type                   :string
#  sequence               :integer
#  contract_id            :integer
#  exp_sell_bid_id        :integer
#  exp_buy_bid_id         :integer
#  exp_sell_ask_id        :integer
#  exp_buy_ask_id         :integer
#  exp_resell_bid_id      :integer
#  exp_rebuy_bid_id       :integer
#  exp_resell_ask_id      :integer
#  exp_rebuy_ask_id       :integer
#  exp_bid_position_id    :integer
#  exp_ask_position_id    :integer
#  exp_escrow_id          :integer
#  trn_sell_offer_id      :integer
#  trn_buy_offer_id       :integer
#  trn_parent_position_id :integer
#  trn_seller_position_id :integer
#  trn_buyer_position_id  :integer
#  red_escrow_id          :integer
#  res_escrow_id          :integer
#  xfields                :hstore           not null
#  jfields                :jsonb            not null
#  exref                  :string
#  uuref                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
