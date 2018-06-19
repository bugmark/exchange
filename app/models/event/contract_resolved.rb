require 'ext/hash'

class Event::ContractResolved < Event

  jsonb_fields_for :payload, Contract

  jsonb_accessor :payload, "uuid" => :string

  validates :uuid , presence: true

  def cast_object
    contract.status = "resolved"
    contract.awarded_to = contract.awardee
    contract
  end

  private

  def contract
    @con ||= Contract.find_by_uuid(uuid)
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
#  tags         :string           default([]), is an Array
#  note         :string
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
