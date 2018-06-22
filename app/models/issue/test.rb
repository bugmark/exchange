class Issue::Test < Issue

end

# == Schema Information
#
# Table name: issues
#
#  id               :bigint(8)        not null, primary key
#  type             :string
#  uuid             :string
#  exid             :string
#  sequence         :integer
#  xfields          :hstore           not null
#  jfields          :jsonb            not null
#  synced_at        :datetime
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
