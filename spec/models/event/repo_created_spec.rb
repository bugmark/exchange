require 'rails_helper'

RSpec.describe Event::RepoCreated, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:           "Test::Repo"       ,
      cmd_uuid:           SecureRandom.uuid  ,
      name:               "ding/dong"        ,
      uuid:               SecureRandom.uuid  ,
    }.merge(alt)
  end

  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'emits a repo object' do
      obj = subject.ev_cast
      expect(obj).to be_a(Repo)
    end
  end

  describe "Casting" do
    it "increments the repo count" do
      expect(Repo.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(Repo)
      expect(Repo.count).to eq(1)
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
