class Contract::GitHub < Contract

end

# == Schema Information
#
# Table name: contracts
#
#  id             :integer          not null, primary key
#  uuid           :string
#  exid           :string
#  prototype_uuid :integer
#  type           :string
#  status         :string
#  awarded_to     :string
#  maturation     :datetime
#  xfields        :hstore           not null
#  jfields        :jsonb            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  stm_issue_uuid :string
#  stm_repo_uuid  :string
#  stm_title      :string
#  stm_status     :string
#  stm_labels     :string
#  stm_xfields    :hstore           not null
#  stm_jfields    :jsonb            not null
#
