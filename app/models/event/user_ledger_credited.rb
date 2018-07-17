class Event::UserLedgerCredited < Event

  jsonb_accessor :payload, "uuid"   => :string
  jsonb_accessor :payload, "amount" => :float

  validates :uuid   , presence: true
  validates :amount , presence: true

  def cast_object
    ledger.balance += amount if ledger
    ledger
  end

  def influx_fields
    {
      withdraw_amount: self.amount          ,
      new_balance:     ledger.balance
    }
  end

  def tgt_ledger_uuids
    [ledger&.user_uuid]
  end

  private

  def ledger
    @ledger ||= UserLedger.find_by_uuid(uuid)
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
