require 'ext/hash'

class Event::UserCreated < Event

  jsonb_accessor :payload, "uuid"  => :string
  jsonb_accessor :payload, "email" => :string
  jsonb_accessor :payload, "encrypted_password" => :string

  validates :uuid , presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  def cast_object
    User.new(payload.without_blanks)
  end

  def user_uuids
    [uuid]
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
