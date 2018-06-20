require 'ext/hash'

class Event::EscrowUpdated < Event

  jsonb_fields_for :payload, Escrow

  validates :uuid , presence: true

  def influx_tags
    {
      type: escrow.type
    }.without_blanks
  end

  def influx_fields
    {
      id:            escrow.id             ,
      uuid:          escrow.uuid           ,
      contract_uuid: escrow.contract_uuid  ,
      sequence:      escrow.sequence       ,
      fixed_value:   escrow.fixed_values   ,
      unfixed_value: escrow.unfixed_values ,
      total_value:   escrow.fixed_values + escrow.unfixed_values
    }.without_blanks
  end

  def cast_object
    escrow
  end

  def escrow
    @esc ||= Escrow.find_by_uuid(uuid)
  end

  def tgt_user_uuids
    escrow.users.pluck(:uuid)
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
