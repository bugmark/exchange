class Bid::GitHub < Bid

end

# == Schema Information
#
# Table name: bids
#
#  id                  :integer          not null, primary key
#  type                :string
#  mode                :string
#  user_id             :integer
#  contract_id         :integer
#  token_value         :integer
#  status              :string
#  offer_expiration    :datetime
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
#  stake               :integer          default(1), not null
#  counter             :integer          default(1), not null
#
