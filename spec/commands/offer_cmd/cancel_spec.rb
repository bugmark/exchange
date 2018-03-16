require 'rails_helper'

RSpec.describe OfferCmd::Cancel do

  let(:offer_bu) { FB.create(:offer_bu).offer        }
  let(:klas)     { described_class                   }
  subject        { klas.new(offer_bu)                }

  describe "Object Existence" do
    it { should be_a klas   }
    it { should be_valid    }
  end

  describe "#project", USE_VCR do
    it 'saves the object to the database' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      hydrate(offer_bu)
      expect(Offer.count).to eq(1)
      expect(Offer.open.count).to eq(1)
      expect(Offer.canceled.count).to eq(0)
      subject.project
      expect(Offer.count).to eq(1)
      expect(Offer.open.count).to eq(0)
      expect(Offer.canceled.count).to eq(1)
    end
  end
end

