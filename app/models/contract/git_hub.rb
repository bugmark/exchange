class Contract::GitHub < Contract

end

# == Schema Information
#
# Table name: contracts
#
#  id               :bigint(8)        not null, primary key
#  uuid             :string
#  prototype_uuid   :integer
#  type             :string
#  status           :string
#  awarded_to       :string
#  maturation       :datetime
#  xfields          :hstore           not null
#  jfields          :jsonb            not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stm_issue_uuid   :string
#  stm_tracker_uuid :string
#  stm_title        :string
#  stm_body         :string
#  stm_status       :string
#  stm_labels       :string
#  stm_trader_uuid  :string
#  stm_group_uuid   :string
#  stm_currency     :string
#  stm_paypro_uuid  :string
#  stm_comments     :jsonb            not null
#  stm_jfields      :jsonb            not null
#  stm_xfields      :hstore           not null
#
