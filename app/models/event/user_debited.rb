class Event::UserDebited < Event

  jsonb_accessor :payload, "uuid"   => :string
  jsonb_accessor :payload, "amount" => :float

  jsonb_accessor :jfields, :transfer_uuid => :string

  validates :uuid   , presence: true
  validates :amount , presence: true

  def cast_object
    user = User.find_by_uuid(uuid)
    user.balance += amount if user
    user
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
