class Amendment < ApplicationRecord

  has_paper_trail
  acts_as_list :scope => :contract, :column => :sequence

  belongs_to :contract, :optional => true

end

# == Schema Information
#
# Table name: amendments
#
#  id                 :integer          not null, primary key
#  type               :string
#  sequence           :integer
#  contract_id        :integer
#  sell_offer_id      :integer
#  buy_offer_id       :integer
#  parent_position_id :integer
#  seller_position_id :integer
#  buyer_position_id  :integer
#  xfields            :hstore           not null
#  jfields            :jsonb            not null
#  exref              :string
#  uuref              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
