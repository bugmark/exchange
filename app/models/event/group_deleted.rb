require 'ext/hash'

# TODO: write code
# TODO: write tests
class Event::GroupDeleted < Event

  jsonb_fields_for :payload, User

  validates :uuid , presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  def initialize(opts)
    super(opts)
  end

  def cast_object
    User.new(payload.without_blanks)
  end

  def tgt_user_uuids
    [uuid]
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
