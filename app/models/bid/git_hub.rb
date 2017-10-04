class Bid::GitHub < Bid

end

# == Schema Information
#
# Table name: bids
#
#  id                  :integer          not null, primary key
#  type                :string
#  user_id             :integer
#  contract_id         :integer
#  volume              :integer
#  price               :integer
#  price_limit         :boolean          default(FALSE)
#  all_or_none         :boolean          default(FALSE)
#  status              :string
#  offer_expiration    :datetime
#  contract_maturation :datetime
#  repo_id             :integer
#  bug_id              :integer
#  bug_title           :string
#  bug_status          :string
#  bug_labels          :string
#  jfields             :jsonb            not null
#  exref               :string
#  uuref               :string
#
