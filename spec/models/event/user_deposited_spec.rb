require 'rails_helper'

RSpec.describe Event::UserDeposited, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:           "Test::UserDeposited"      ,
      cmd_uuid:           SecureRandom.uuid          ,
      uuid:               user.uuid                  ,
      amount:             100.0                      ,
    }.merge(alt)
  end

  let(:user)   { FB.create(:user).user   }
  let(:klas)   { described_class         }
  subject      { klas.new(valid_params)  }

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
    it "increments the user balance" do
      expect(user.balance).to eq(1000.0)
      expect(Event.count).to eq(2)
      obj = subject.ev_cast
      user.reload
      expect(obj).to be_a(User)
      expect(Event.count).to eq(3)
      expect(User.count).to  eq(1)
      expect(user.balance).to eq(1100.0)
    end
  end

  describe "Deposit to a non-existant user" do
    it "blows up", :focus do
      sub = klas.new(valid_params(uuid: "DUMMY"))
      obj = sub.ev_cast
      expect(obj).to be_nil
      expect(User.first.balance).to eq(1000.0)
      expect(Event.count).to eq(2)
    end
  end
end

# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  type         :string
#  uuid         :string
#  cmd_type     :string
#  cmd_uuid     :string
#  local_hash   :string
#  chain_hash   :string
#  data         :jsonb            not null
#  jfields      :jsonb            not null
#  user_uuids   :string           default([]), is an Array
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
