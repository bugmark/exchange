require 'rails_helper'

RSpec.describe OfferCmd::CreateCounter do

  def counter_params(args = {})
    {
      user_uuid: user.uuid
    }.merge(args)
  end

  let(:offer_bf) { FB.create(:offer_bf).offer          }
  let(:user)     { FB.create(:user).user               }
  let(:klas)     { described_class                     }
  subject        { klas.new(offer_bf, counter_params)  }

  describe "Object Existence" do
    it { should be_a klas   }
  end

  describe "#project" do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      hydrate(offer_bf)
      expect(Offer.count).to eq(1)
      subject.project
      expect(Offer.count).to eq(2)
    end

    it 'generates the right maturation' do
      cmd       = subject.project
      new_offer = cmd.offer
      expect(new_offer).to be_present
      expect(new_offer.maturation_range).to be_present
      expect(new_offer.maturation_range).to eq(offer_bf.maturation_range)
    end

    it 'has a matching offer' do
      new_offer = subject.project.offer
      match     = new_offer.qualified_counteroffers(:expand)
      expect(match.length).to eq(1)
    end
  end
end