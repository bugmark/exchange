require 'ext/hash'

class Event::RepoCreated < Event

  jsonb_fields_for :payload, Repo

  validates :type       , presence: true
  validates :name       , presence: true
  validates :event_type , presence: true
  validates :event_uuid , presence: true

  def cast_object
    Repo.new(payload.without_blanks)
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
