class Event::UserCreated < Event

  def project
    "TBD"
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string
#  uuref        :string
#  cmd_type     :string
#  cmd_id       :string
#  local_hash   :string
#  chain_hash   :string
#  data         :jsonb            not null
#  jfields      :jsonb            not null
#  user_ids     :integer          default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
