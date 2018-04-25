require 'rails_helper'

RSpec.describe Event::OfferCanceled, :type => :model do

  def valid_params(alt = {})
    {
      :cmd_type       => "Test::Offer::Clone"  ,
      :cmd_uuid       => SecureRandom.uuid     ,
      :uuid           => offer.uuid            ,
    }.merge(alt)
  end

  let(:offer) { FB.create(:offer_bf).offer   }
  let(:klas)  { described_class              }
  subject     { klas.new(valid_params)       }

  describe "object creation" do
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
      hydrate(offer)
      expect(Event.count).to eq(5)
      obj = subject.ev_cast
      expect(obj).to be_a(Offer)
      expect(Event.count).to eq(6)
    end

    it "has the right status" do
      obj = subject.ev_cast
      expect(obj).to be_a(Offer)
      expect(obj.status).to eq("canceled")
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
