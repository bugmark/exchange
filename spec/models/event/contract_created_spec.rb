require 'rails_helper'

RSpec.describe Event::ContractCreated, :type => :model do

  def valid_params(alt = {})
    {
      :cmd_type       => "Test::Contract::Create"   ,
      :cmd_uuid       => SecureRandom.uuid          ,
      :uuid           => SecureRandom.uuid          ,
      :maturation     => BugmTime.now + 1.hour      ,
      :type           => "Contract::Test"           ,
      :status         => "open"                     ,
    }.merge(alt)
  end

  let(:klas)   { described_class                   }
  subject      { klas.new(valid_params)            }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      expect(subject).to be_valid
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Projecting" do
    it "creates an event" do
      expect(Event.count).to eq(0)
      obj = subject.ev_cast
      expect(obj).to be_a(Contract)
      expect(Event.count).to eq(1)
    end
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
