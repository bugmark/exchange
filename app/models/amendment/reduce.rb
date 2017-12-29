class Amendment::Reduce < Amendment

end

# == Schema Information
#
# Table name: amendments
#
#  id            :integer          not null, primary key
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
