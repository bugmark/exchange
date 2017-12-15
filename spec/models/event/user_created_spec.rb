require 'rails_helper'

RSpec.describe Event::UserCreated, :type => :model do

  PWD = "dingo" #..

  def valid_params(alt = {})
    {
      cmd_type:           "TESTCMD"                  ,
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
      subject.cast
      expect(subject).to be_valid #.
    end

    it 'prevents calling save' do
      expect {subject.save}.to raise_error(NoMethodError)
    end
  end

  describe "Casting" do
    it "increments the user count" do
      expect(User.count).to eq(0)
      result = subject.cast
      expect(result).to be_a(User)
      expect(Event.count).to eq(1)
      expect(User.count).to eq(1)
      expect(User.first.balance).to eq(0.0)
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
