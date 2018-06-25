class Event::UserLedgerDebited < Event

  jsonb_accessor :payload, "uuid"   => :string
  jsonb_accessor :payload, "amount" => :float

  validates :uuid   , presence: true
  validates :amount , presence: true

  def cast_object
    ledger.balance -= amount if ledger
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
