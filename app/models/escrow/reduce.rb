class Escrow::Reduce < Escrow

end

# == Schema Information
#
# Table name: escrows
#
#  id             :integer          not null, primary key
#  type           :string
#  sequence       :integer
#  contract_id    :integer
#  contract_uuid  :string
#  amendment_id   :integer
#  amendment_uuid :string
#  fixed_value    :float            default(0.0)
#  unfixed_value  :float            default(0.0)
#  exid           :string
#  uuid           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
