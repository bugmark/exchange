require 'rails_helper'

RSpec.describe Event::IssueSynced, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:           "Test::BugCreated"         ,
      cmd_uuid:           SecureRandom.uuid          ,
      type:               "Issue::GitHub"            ,
      uuid:               SecureRandom.uuid          ,
      stm_title:          "ping/pong"                ,
      stm_tracker_uuid:      tracker.uuid                  ,
      exid:               "bingbingbing"
    }.merge(alt)
  end

  let(:tracker)   { FB.create(:tracker).tracker   }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do #..
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'emits a bug object' do
      obj = subject.ev_cast
      expect(obj).to be_a(Issue)
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Casting", USE_VCR do
    it "increments the issue count" do
      expect(Issue.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(Issue)
      expect(Event.count).to eq(2)
      expect(Issue.count).to eq(1)
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
