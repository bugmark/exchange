class Issue::Test < Issue

end

# == Schema Information
#
# Table name: issues
#
#  id             :integer          not null, primary key
#  type           :string
#  uuid           :string
#  exid           :string
#  xfields        :hstore           not null
#  jfields        :jsonb            not null
#  synced_at      :datetime
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
