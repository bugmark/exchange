class Contract::GitHub < Contract

end

# == Schema Information
#
# Table name: contracts
#
#  id                  :integer          not null, primary key
#  type                :string
#  status              :string
#  ownership           :string
#  awarded_to          :string
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  bug_presence        :boolean
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
