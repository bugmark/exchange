require 'ext/hash'

class Event::UserMembershipOpened < Event

  jsonb_fields_for :payload, UserMembership

  validates :uuid      , presence: true
  validates :user_uuid , presence: true
  validates :group_uuid, presence: true

  def cast_object
    membership
  end

  def tgt_user_uuids
    [user_uuid]
  end

  private

  def membership
    membership = UserMembership.find_by(uuid: uuid) || UserMembership.new
    membership.update_attributes(membership_args(payload))
    membership
  end

  def membership_args(xargs)
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
