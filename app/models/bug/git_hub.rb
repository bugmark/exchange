class Bug::GitHub < Bug

  # belongs_to :repo

end

# == Schema Information
#
# Table name: bugs
#
#  id          :integer          not null, primary key
#  repo_id     :integer
#  type        :string
#  api_url     :string
#  http_url    :string
#  title       :string
#  description :string
#  status      :string
#  labels      :text             default([]), is an Array
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
