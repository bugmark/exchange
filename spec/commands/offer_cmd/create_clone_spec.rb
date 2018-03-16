require 'rails_helper'

RSpec.describe OfferCmd::CreateClone do

  def clone_params(args = {})
    {
      user_uuid: user.uuid
    }.merge(args)
  end

  let(:offer_bf) { FB.create(:offer_bf).offer           }
  let(:user)     { FB.create(:user).user                }
  let(:klas)     { described_class                      }
  subject        { klas.new(offer_bf, clone_params)     }

  describe "Object Existence" do
    it { should be_a klas   }
    it { should be_valid    }
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

    it "copies the maturation date" do
      hydrate(offer_bf)
      obj = klas.new(offer_bf, {}).project.offer
      expect(obj.maturation_range).to eq(offer_bf.maturation_range)
    end

    it 'updates the clone params' do
      hydrate(offer_bf)
      expect(Offer.count).to eq(1)
      expect(Event.count).to eq(5)
      result = klas.new(offer_bf, stm_issue_uuid: "asdf").project
      expect(Offer.count).to eq(2)
      expect(Event.count).to eq(6)
      expect(result.offer.stm_issue_uuid).to eq("asdf")
    end
  end

  describe "exceeding user balance and reserves" do
    it "does not create an offer" do
      hydrate(offer_bf)
      expect(Offer.count).to eq(1)
      klas.new(offer_bf, volume: 10000).project
      expect(Offer.count).to eq(1)
    end
  end
end