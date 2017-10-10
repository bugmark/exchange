class Bug::GitHub < Bug

  # TODO: fixme
  def html_url
    "https://github.com/TBD"
  end

end

# == Schema Information
#
# Table name: bugs
#
#  id          :integer          not null, primary key
#  repo_id     :integer
#  type        :string
#  title       :string
#  description :string
#  status      :string
#  labels      :text             default([]), is an Array
#  xfields     :hstore           not null
#  jfields     :jsonb            not null
#  synced_at   :datetime
#  exref       :string
#  uuref       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
