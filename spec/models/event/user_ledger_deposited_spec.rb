require 'rails_helper'

RSpec.describe Event::UserLedgerDeposited, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:  "Test::LedgerDeposited"  ,
      cmd_uuid:  SecureRandom.uuid        ,
      uuid:      ledger.uuid              ,
      amount:    100.0                    ,
    }.merge(alt)
  end

  let(:ledger) { FB.create(:user_ledger).ledger    }
  let(:klas)   { described_class                   }
  subject      { klas.new(valid_params)            }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Casting" do
    it "increments the ledger balance" do
      expect(ledger.balance).to eq(0.0)
      expect(Event.count).to eq(4)
      obj = subject.ev_cast
      ledger.reload
      expect(obj).to be_a(UserLedger)
      expect(Event.count).to eq(5)
      expect(UserLedger.count).to  eq(1)
      expect(ledger.balance).to eq(100.0)
    end
  end

  describe "Deposit to a non-existant ledger" do
    it "blows up" do
      sub = klas.new(valid_params(uuid: "DUMMY"))
      obj = sub.ev_cast
      expect(obj).to be_nil
      expect(UserLedger.first.balance).to eq(0.0)
      expect(Event.count).to eq(4)
    end
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
