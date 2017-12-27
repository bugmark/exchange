require 'rails_helper'

RSpec.describe ContractCmd::Cross::Reduce do

  include_context 'Integration Environment'

  let(:offer_su) { FBX.offer_su.offer                     }
  let(:offer_sf) { FBX.offer_sf.offer                     }
  let(:user)     { FB.create(:user).user                  }
  let(:klas)     { described_class                        }
  subject        { klas.new(offer_su, :reduce)            }

  describe "Attributes", USE_VCR do 
    # it { should respond_to :offer         }
    # it { should respond_to :counters      }
    # it { should respond_to :type          }
  end

  describe "Object Existence", USE_VCR do
    # it { should be_a klas           }
    # it { should_not be_valid        }
  end

  # describe "Subobjects", USE_VCR do
  #   it { should respond_to :subobject_symbols } #
  #   it 'returns an array' do
  #     expect(subject.subobject_symbols).to be_an(Array)
  #   end
  # end

  # describe "Delegated Object", USE_VCR do
  #   it 'has a present Offer' do
  #     expect(subject.offer).to be_present
  #   end #
  #
  #   it 'has a Offer with the right class' do
  #     expect(subject.offer).to be_a(Offer)
  #   end
  # end

  # describe "#project - invalid subject", USE_VCR do
  #   before(:each) { hydrate(offer_sf) }
  #
  #   it 'detects an invalid object', :focus do
  #     subject.cmd_cast
  #     expect(subject).to be_valid
  #   end
  #
  #   it 'gets the right object count' do
  #     expect(Contract.count).to eq(1)
  #     subject.cmd_cast
  #     expect(Contract.count).to eq(1)
  #   end
  # end

  # describe "#project - valid subject", USE_VCR do
  #   it 'detects a valid object' do
  #     hydrate(offer_sf)
  #     subject.cmd_cast
  #     expect(subject).to be_valid
  #   end
  #
  #   it 'gets the right object count' do
  #     hydrate(offer_sf)
  #     expect(Contract.count).to eq(1)
  #     subject.cmd_cast
  #     expect(Contract.count).to eq(1)
  #   end
  #
  #   it 'adjusts the user balance' do
  #     hydrate(offer_sf, offer_su)
  #     u1 = offer_sf.user
  #     u2 = offer_su.user
  #     expect(u1.balance).to eq(996.0)
  #     expect(u2.balance).to eq(994.0)
  #     subject.cmd_cast
  #     u1.reload
  #     u2.reload
  #     expect(u1.balance).to eq(992.0)   # SHOULD BE 994 ...
  #     expect(u2.balance).to eq(988.0)   # SHOULD BE 996
  #   end
  # end

  describe "#event_data", USE_VCR do
    # it 'returns a hash' do
    #   expect(subject.event_data).to be_a(Hash)
    # end
  end

  describe "crossing", USE_VCR do
    let(:lcl_ask) { FB.create(:offer_bf).offer }

    context "with single bid" do
      # it 'matches higher values' do
      #   FB.create(:offer_bu)
      #   klas.new(lcl_ask, :reduce).cmd_cast
      #   expect(Contract.count).to eq(0)
      #   expect(Position.count).to eq(0)
      # end

      # it 'generates position ownership' do
      #   FB.create(:offer_bu)
      #   klas.new(lcl_ask, :reduce).cmd_cast
      #   expect(Position.first.user_id).to_not be_nil
      #   expect(Position.last.user_id).to_not be_nil
      # end

    #   it 'matches equal values' do
    #     FB.create(:offer_bu)
    #     klas.new(lcl_ask, :reduce).cmd_cast
    #     expect(Contract.count).to eq(1)
    #   end
    #
    #   it 'fails to match lower values' do
    #     FB.create(:offer_bu, price: 0.1, volume: 1)
    #     expect(Contract.count).to eq(0)
    #     klas.new(lcl_ask, :reduce).cmd_cast
    #     expect(Contract.count).to eq(0)
    #   end
    # end

    # context "with multiple bids" do
    #   it 'matches higher value' do
    #     _bid1 = FB.create(:offer_bu, price: 0.5, volume: 10).offer
    #     _bid2 = FB.create(:offer_bu, price: 0.5, volume: 10).offer
    #     klas.new(lcl_ask, :reduce).cmd_cast
    #     expect(Contract.count).to eq(0)
    #   end
    #
    #   it 'matches equal value' do
    #     _bid1 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid2 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     klas.new(lcl_ask, :reduce).cmd_cast
    #     expect(Contract.count).to eq(1)
    #   end
    #
    #   it 'fails to match lower value' do
    #     _bid1 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid2 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     klas.new(lcl_ask, :reduce).cmd_cast
    #     expect(Contract.count).to eq(1)
    #   end
    # end

    # context "with extra bids" do
    #   it 'does minimal matching' do
    #     _bid1 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid2 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid3 = FB.create(:offer_bu, price: 0.6, volume: 10).offer
    #     klas.new(lcl_ask, :reduce).cmd_cast
    #     expect(Contract.count).to eq(1)
    #     expect(Offer.assigned.count).to eq(0)
    #     expect(Offer.unassigned.count).to eq(0)
    #   end
    end
  end
end

