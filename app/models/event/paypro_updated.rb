require 'ext/hash'

class Event::PayproUpdated < Event

  jsonb_accessor :payload, "uuid"   => :string
  jsonb_accessor :payload, "name"   => :string
  jsonb_accessor :payload, "status" => :string

  validates :uuid, presence: true
  validates :name, presence: true

  def cast_object
    obj = Paypro.find_by_uuid(uuid)
    obj.name   = name   if name
    obj.status = status if status
    obj
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
