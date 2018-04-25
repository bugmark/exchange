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
#  id            :bigint(8)        not null, primary key
#  uuid          :string
#  exid          :string
#  type          :string
#  sequence      :integer
#  contract_uuid :string
#  xfields       :hstore           not null
#  jfields       :jsonb            not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
