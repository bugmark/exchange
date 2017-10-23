class Escrow::Reduce < Amendment

end

# == Schema Information
#
# Table name: amendments
#
#  id          :integer          not null, primary key
#  type        :string
#  sequence    :integer
#  contract_id :integer
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
