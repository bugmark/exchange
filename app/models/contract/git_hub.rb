class Contract::GitHub < Contract

end

# == Schema Information
#
# Table name: contracts
#
#  id            :integer          not null, primary key
#  prototype_id  :integer
#  type          :string
#  status        :string
#  awarded_to    :string
#  maturation    :datetime
#  xfields       :hstore           not null
#  jfields       :jsonb            not null
#  exid          :string
#  uuid          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  stm_bug_id    :integer
#  stm_bug_uuid  :string
#  stm_repo_id   :integer
#  stm_repo_uuid :string
#  stm_title     :string
#  stm_status    :string
#  stm_labels    :string
#  stm_xfields   :hstore           not null
#  stm_jfields   :jsonb            not null
#
