require 'rails_helper'

RSpec.describe Event::OfferCloned, :type => :model do

  def valid_params(alt = {})
    {
      :cmd_type       => "Test::Offer::Clone"       ,
      :cmd_uuid       => SecureRandom.uuid          ,
      :uuid           => SecureRandom.uuid          ,
      :volume         => 2                          ,
      :price          => 0.6                        ,
      :prototype_uuid => proto.uuid
    }.merge(alt)
  end

  let(:proto)  { FB.create(:offer_bf).offer        }
  let(:klas)   { described_class                   }
  subject      { klas.new(valid_params)            }

  describe "Object Creation", USE_VCR do
    it { should be_valid }

    it 'saves the object to the database' do
      subject.ev_cast
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
      expect(obj).to be_a(Offer)
      expect(Event.count).to eq(6)
    end

    it "copies the maturation date" do
      hydrate(proto)
      obj = subject.ev_cast
      expect(obj.maturation_range).to eq(proto.maturation_range)
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
#  projected_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
