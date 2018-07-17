require 'rails_helper'

RSpec.describe Event::UserCreated, :type => :model do

  PWD = "dingo"

  def valid_params(alt = {})
    {
      cmd_type:           "Test::UserCreated"        ,
      cmd_uuid:           SecureRandom.uuid          ,
      email:              "bing@bong.com"            ,
      uuid:               SecureRandom.uuid          ,
      encrypted_password: User.new(password: PWD).encrypted_password
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

    it 'emits a user object' do
      obj = subject.ev_cast
      expect(obj).to be_a(User) #
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Casting" do
    it "increments the user count" do
      expect(User.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(User)
      expect(Event.count).to eq(1)
      expect(User.count).to  eq(1)
      expect(User.first.balance).to eq(0.0)
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
