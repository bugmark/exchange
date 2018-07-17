require 'ext/hash'

class Event::EscrowCreated < Event

  jsonb_fields_for :payload, Escrow

  jsonb_accessor :jfields, :transfer_uuid => :string

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
    }.without_blanks
  end

  def cast_object
    escrow
  end

  def escrow
    @esc ||= Escrow.new(payload.without_blanks)
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
