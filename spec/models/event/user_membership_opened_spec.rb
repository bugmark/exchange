require 'rails_helper' #

RSpec.describe Event::UserMembershipOpened, :type => :model do

  def valid_params(alt = {})
    {
      cmd_type:   "Test::UserMembership"  ,
      cmd_uuid:   SecureRandom.uuid  ,
      uuid:       SecureRandom.uuid  ,
      user_uuid:  user.uuid          ,
      group_uuid: group.uuid         ,
    }.merge(alt)
  end

  let(:group)  { FB.create(:user_group).group   }
  let(:user)   { FB.create(:user).user          }
  let(:klas)   { described_class                }
  subject      { klas.new(valid_params)         }

  describe "Object Creation" do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
      expect(subject).to be_valid
    end

    it 'emits a group object' do
      obj = subject.ev_cast
      expect(obj).to be_a(UserMembership)
    end
  end

  describe "Casting" do
    it "increments the paypro count" do
      expect(UserMembership.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(UserMembership)
      expect(UserMembership.count).to eq(1)
    end

    it "increments the event count" do
      expect(Event.count).to eq(0)
      result = subject.ev_cast
      expect(result).to be_a(UserMembership)
      expect(Event.count).to eq(6)
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
