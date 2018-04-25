class Escrow::Resolve < Escrow

end

# == Schema Information
#
# Table name: escrows
#
#  id             :bigint(8)        not null, primary key
#  uuid           :string
#  exid           :string
#  type           :string
#  sequence       :integer
#  contract_uuid  :string
#  amendment_uuid :string
#  fixed_value    :float            default(0.0)
#  unfixed_value  :float            default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
