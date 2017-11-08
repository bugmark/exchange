require 'rails_helper'

RSpec.describe ContractCmd::Cross::Transfer do

  include_context 'Integration Environment'

  let(:sell) { FG.create(:offer_su, user_id: usr1.id).offer               }
  let(:buy)  { FG.create(:offer_bu , user_id: usr2.id, price: 0.4).offer   }
  let(:user) { FG.create(:user).user                                      }
  let(:klas) { described_class                                            }
  subject    { klas.new(sell, :transfer)                                  }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer         }
    it { should respond_to :counters      }
    it { should respond_to :type          }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas       }
    it { should be_valid        }
  end

  describe "Subobjects", USE_VCR do
    it { should respond_to :subobject_symbols }
    it 'returns an array' do
      expect(subject.subobject_symbols).to be_an(Array)
    end
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
    before(:each) { hydrate(buy) }

    it 'detects an invalid object' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
    end
  end

  describe "#project - valid subject", USE_VCR do
    before(:each) { hydrate(buy) }

    it 'detects a valid object' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
    end

    # it 'sets the contract status' do
    #   subject.project
    #   expect(subject.commit.contract.status).to eq("open")
    # end

    # it 'adjusts the user balance' do
    # TODO
    #   expect(usr1.balance).to eq(100.0)
    #   expect(usr2.balance).to eq(100.0)
    #   subject.project
    #   usr1.reload
    #   usr2.reload
    #   expect(usr1.balance).to eq(94.0)
    #   expect(usr2.balance).to eq(94.0)
    # end
  end

  describe "#event_data", USE_VCR do
    it 'returns a hash' do
      expect(subject.event_data).to be_a(Hash)
    end
  end

  describe "#event_save", USE_VCR do
    it 'creates an event' do
      expect(EventLine.count).to eq(0)
      subject.save_event
      expect(EventLine.count).to eq(8)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(Contract.count).to eq(0)
      subject.save_event.project
      expect(EventLine.count).to eq(8)   # TODO: retest
      expect(Contract.count).to eq(1)
    end
  end

  describe "crossing", USE_VCR do
    let(:lcl_ask) { FG.create(:offer_bf).offer }

    context "with single bid" do
      # it 'matches higher values' do
      #   FG.create(:offer_bu)
      #   klas.new(lcl_ask, :transfer).project
      #   expect(Contract.count).to eq(0)
      #   expect(Position.count).to eq(0)
      # end

      # it 'generates position ownership' do
      #   FG.create(:offer_bu)
      #   klas.new(lcl_ask, :transfer).project
      #   expect(Position.first.user_id).to_not be_nil
      #   expect(Position.last.user_id).to_not be_nil
      # end

    #   it 'matches equal values' do
    #     FG.create(:offer_bu)
    #     klas.new(lcl_ask, :transfer).project
    #     expect(Contract.count).to eq(1)
    #   end
    #
    #   it 'fails to match lower values' do
    #     FG.create(:offer_bu, price: 0.1, volume: 1)
    #     expect(Contract.count).to eq(0)
    #     klas.new(lcl_ask, :transfer).project
    #     expect(Contract.count).to eq(0)
    #   end
    # end

    # context "with multiple bids" do
    #   it 'matches higher value' do
    #     _bid1 = FG.create(:offer_bu, price: 0.5, volume: 10).offer
    #     _bid2 = FG.create(:offer_bu, price: 0.5, volume: 10).offer
    #     klas.new(lcl_ask, :transfer).project
    #     expect(Contract.count).to eq(0)
    #   end
    #
    #   it 'matches equal value' do
    #     _bid1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     klas.new(lcl_ask, :transfer).project
    #     expect(Contract.count).to eq(1)
    #   end
    #
    #   it 'fails to match lower value' do
    #     _bid1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     klas.new(lcl_ask, :transfer).project
    #     expect(Contract.count).to eq(1)
    #   end
    # end

    # context "with extra bids" do
    #   it 'does minimal matching' do
    #     _bid1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     _bid3 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
    #     klas.new(lcl_ask, :transfer).project
    #     expect(Contract.count).to eq(1)
    #     expect(Offer.assigned.count).to eq(0)
    #     expect(Offer.unassigned.count).to eq(0)
    #   end
    end
  end
end

