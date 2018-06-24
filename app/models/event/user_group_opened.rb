require 'ext/hash'

class Event::UserGroupOpened < Event

  jsonb_fields_for :payload, UserGroup

  validates :uuid      , presence: true
  validates :owner_uuid, presence: true

  def cast_object
    group
  end

  def tgt_user_uuids
    [owner_uuid]
  end

  private

  def group
    group = UserGroup.find_by(uuid: uuid) || UserGroup.new
    group.update_attributes(group_args(payload))
    group
  end

  def group_args(xargs)
    args = xargs.stringify_keys.without_blanks
    args["status"] = "open"
    args
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :bigint(8)        not null, primary key
#  event_type   :string
#  event_uuid   :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  payload      :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  tags         :string
#  note         :string
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
