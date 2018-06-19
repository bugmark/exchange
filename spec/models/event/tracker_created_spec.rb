require 'rails_helper'

RSpec.describe Event::TrackerCreated, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:           "Test::Tracker"       ,
      cmd_uuid:           SecureRandom.uuid  ,
      name:               "mvscorg/bugmark"  ,
      uuid:               SecureRandom.uuid  ,
      type:               "Tracker::GitHub"
    }.merge(alt)
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'emits a tracker object' do
      obj = subject.ev_cast
      expect(obj).to be_a(Tracker)
    end
  end

  describe "Casting" do
    it "increments the tracker count", USE_VCR do
      expect(Tracker.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(Tracker)
      expect(Tracker.count).to eq(1)
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
#  tags         :string           default([]), is an Array
#  note         :string
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
