require 'ext/hash'

class Event::BugSynced < Event

  EXTRAS = {extras: {"html_url" => :string, "comments" => :string}}

  jsonb_fields_for :payload, Issue, EXTRAS

  validates :type      , presence: true
  validates :exid      , presence: true
  validates :stm_title , presence: true

  def cast_object
    bug = Issue.find_or_initialize_by(exid: payload["exid"])
    bug.assign_attributes(payload.without_blanks)
    bug
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
