require 'ext/hash'

class Event::RepoSynced < Event

  jsonb_fields_for :payload, Repo

  validates :uuid , presence: true

  def cast_object
    repo = Repo.find_or_initialize_by(uuid: payload["uuid"])
    repo.assign_attributes(synced_at: Time.now)
    repo
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
