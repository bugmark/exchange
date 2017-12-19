require 'rails_helper'

RSpec.describe Event::BugSynced, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:           "Test::BugCreated"        ,
      cmd_uuid:           SecureRandom.uuid          ,
      type:               "Bug::GitHub"              ,
      uuid:               SecureRandom.uuid          ,
      stm_title:          "ping/pong"                ,
      stm_repo_id:        repo.id                    ,
      exid:               "bingbingbing"
    }.merge(alt)
  end

  let(:repo)   { FB.create(:repo).repo   }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'emits a bug object' do
      obj = subject.ev_cast
      expect(obj).to be_a(Bug)
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Casting", USE_VCR do
    it "increments the bug count" do
      expect(Bug.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(Bug)
      expect(Event.count).to eq(2)
      expect(Bug.count).to  eq(1)
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