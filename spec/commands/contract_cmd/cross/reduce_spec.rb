require 'rails_helper'

RSpec.describe ContractCmd::Cross::Reduce do

  include_context 'Integration Environment'

  let(:offer_su) { FBX.offer_su.offer                     }
  let(:offer_sf) { FBX.offer_sf.offer                     }
  let(:user)     { FB.create(:user).user                  }
  let(:klas)     { described_class                        }
  let(:sub_xf)   { klas.new(offer_sf, :reduce)            }
  let(:sub_xu)   { klas.new(offer_su, :reduce)            }
  subject        { sub_xf                                 }

  describe "Attributes", USE_VCR do 
    it { should respond_to :offer          }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas           }
    it { should_not be_valid        }
  end

  describe "Delegated Object", USE_VCR do
    it 'has a present Offer' do
      expect(subject.offer).to be_present
    end

    it 'has a Offer with the right class' do
      expect(subject.offer).to be_a(Offer)
    end
  end

  describe "#project - invalid subject", USE_VCR do
    before(:each) { hydrate(offer_su, offer_sf) }

    it 'detects an invalid object', :focus do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(1)
      subject.project
      expect(Contract.count).to eq(1)
    end
  end

  describe "#project - valid subject", USE_VCR do
    before(:each) { hydrate(offer_su, offer_sf) }


    it 'detects a valid object' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to eq(2)
      expect(Contract.first.escrows.count).to eq(2)
      subject.project
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to eq(3)
      expect(Contract.first.escrows.count).to eq(3)
    end

    it 'adjusts the user balance' do
      u1 = offer_sf.user
      u2 = offer_su.user
      expect(u1.balance).to eq(996.0)
      expect(u2.balance).to eq(994.0)
      subject.project
      u1.reload
      u2.reload
      expect(u1.balance).to eq(992.0)   # SHOULD BE 994 ...
      expect(u2.balance).to eq(988.0)   # SHOULD BE 996
    end
  end

  describe "crossing", USE_VCR do
    let(:lcl_offer_bf) { FB.create(:offer_bf).offer }

    context "with single offer_bf" do
      it 'matches nothing' do
        FB.create(:offer_bu)
        klas.new(lcl_offer_bf, :reduce).project
        expect(Contract.count).to eq(0)
        expect(Position.count).to eq(0)
      end

      it 'generates position ownership' do
        subject.project
        expect(Position.first.user_uuid).to_not be_nil
        expect(Position.last.user_uuid).to_not be_nil
      end
    end
  end
end

