require 'rails_helper'

RSpec.describe ContractCmd::Cross::Expand do

  include_context 'Integration Environment'

  let(:ask)  { FG.create(:buy_ask, user_id: usr1.id).offer         }
  let(:bid)  { FG.create(:buy_bid, user_id: usr2.id).offer         }
  let(:user) { FG.create(:user).user                               }
  let(:klas) { described_class                                     }
  subject    { klas.new(ask, :expand)                              }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer         }
    it { should respond_to :counters      }
    it { should respond_to :type          }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas       }
    it { should_not be_valid    }
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
    before(:each) { hydrate(bid) }

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
    before(:each) { hydrate(bid) }

    it 'detects a valid object' do
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      expect(Contract.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
    end

    it 'sets the contract status' do
      subject.project
      expect(subject.commit.contract.status).to eq("open")
    end

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
      expect(EventLine.count).to eq(4)
    end

    it 'chains with #project' do
      expect(EventLine.count).to eq(0)
      expect(Contract.count).to eq(0)
      subject.save_event.project
      expect(EventLine.count).to eq(4)   # TODO: retest ..
      expect(Contract.count).to eq(0)
    end
  end

  describe "crossing", USE_VCR do
    let(:lcl_ask) { FG.create(:buy_ask).offer }

    context "with single bid" do
      it 'matches higher values' do
        FG.create(:buy_bid)
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(1)
        expect(Position.count).to eq(2)
      end

      it 'generates position ownership' do
        FG.create(:buy_bid)
        klas.new(lcl_ask, :expand).project
        expect(Position.first.user_id).to_not be_nil
        expect(Position.last.user_id).to_not be_nil
      end

      it 'attaches offer to position' do
        FG.create(:buy_bid)
        klas.new(lcl_ask, :expand).project
        expect(Position.first.offer_id).to_not be_nil #
        expect(Position.last.offer_id).to_not be_nil
      end

      it 'matches equal values' do
        FG.create(:buy_bid)
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower values' do
        FG.create(:buy_bid, price: 0.1, volume: 1)
        expect(Contract.count).to eq(0)
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(0)
      end
    end

    context "with multiple bids" do
      it 'matches higher value' do
        _bid1 = FG.create(:buy_bid, price: 0.5, volume: 10).offer
        _bid2 = FG.create(:buy_bid, price: 0.5, volume: 10).offer
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(0)
      end

      it 'matches equal value' do
        _bid1 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        _bid2 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower value' do
        _bid1 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        _bid2 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(1)
      end
    end

    context "with extra bids" do
      it 'does minimal matching' do
        _bid1 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        _bid2 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        _bid3 = FG.create(:buy_bid, price: 0.6, volume: 10).offer
        klas.new(lcl_ask, :expand).project
        expect(Contract.count).to eq(1)
        expect(Offer.assigned.count).to eq(2)
        expect(Offer.unassigned.count).to eq(2)
      end
    end
  end
end

