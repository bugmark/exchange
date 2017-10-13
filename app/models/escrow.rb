class Escrow < ApplicationRecord

end

# == Schema Information
#
# Table name: escrows
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  parent_id   :integer
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
