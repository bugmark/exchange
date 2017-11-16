require 'rails_helper'

RSpec.describe ContractCmd::Cross::Expand do

  include_context 'Integration Environment'

  let(:offer_bf)  { FG.create(:offer_bf, user_id: usr1.id).offer         }
  let(:offer_bu)  { FG.create(:offer_bu, user_id: usr2.id).offer         }
  let(:user)      { FG.create(:user).user                                }
  let(:klas)      { described_class                                      }
  subject         { klas.new(offer_bf, :expand)                          }

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
    before(:each) { hydrate(offer_bu) }

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
    before(:each) { hydrate(offer_bu) }

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

    it 'adjusts the user balance' do
      expect(usr1.balance).to eq(100.0)
      expect(usr2.balance).to eq(100.0)
      subject.project
      usr1.reload
      usr2.reload
      expect(usr1.balance).to eq(96.0)
      expect(usr2.balance).to eq(94.0)
    end
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
    let(:lcl_offer_bf) { FG.create(:offer_bf).offer }

    context "with single offer_bu" do
      it 'matches higher values' do
        FG.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Position.count).to eq(2)
      end

      it 'generates position ownership' do
        FG.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.first.user_id).to_not be_nil
        expect(Position.last.user_id).to_not be_nil
      end

      it 'attaches offer to position' do
        FG.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Position.first.offer_id).to_not be_nil #
        expect(Position.last.offer_id).to_not be_nil
      end

      it 'matches equal values' do
        FG.create(:offer_bu)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower values' do
        FG.create(:offer_bu, price: 0.1, volume: 1)
        expect(Contract.count).to eq(0)
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(0)
      end
    end

    context "with multiple offer_bus" do
      it 'matches higher value' do
        _offer_bu1 = FG.create(:offer_bu, price: 0.5, volume: 10).offer
        _offer_bu2 = FG.create(:offer_bu, price: 0.5, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(0)
      end

      it 'matches equal value' do
        _offer_bu1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower value' do
        _offer_bu1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
      end
    end

    context "with extra offer_bus" do
      it 'does minimal matching' do
        _offer_bu1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _offer_bu3 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Offer.assigned.count).to eq(2)
        expect(Offer.unassigned.count).to eq(2)
      end
    end

    context "with multiple positions" do
      it "generates multiple positions", focus: true do
        _offer_bu1 = FG.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu2 = FG.create(:offer_bu, price: 0.6, volume: 3).offer
        _offer_bu3 = FG.create(:offer_bu, price: 0.6, volume: 4).offer
        klas.new(lcl_offer_bf, :expand).project
        expect(Contract.count).to eq(1)
        expect(Position.fixed.count).to eq(1)
        expect(Position.unfixed.count).to eq(3)
      end

      # it "generates a single amendment" #.....
      # it "has compatible volumes on both sides of the escrow"
      # it "generates a single price"
      # it "generates a single maturation date"
    end

    context "with overlapping prices" do
    #   it "generates a median price"
    end

    context "with non-overlapping prices" do
      # it "fails to generate a cross"
    end

    context "with overlapping maturity dates" do
      # it "generates a median date"
    end

    context "with non-overlapping maturity dates" do
      # it "fails to generate a cross"
    end

    context "with pre-existing contract" do
      # it "amends the contract"
    end

    context "with no pre-existing contract" do
      # it "generates a contract"
    end

    context "with extra volume on the fixed side" do
      # it "generates a re-offer"
      # it "makes re-offer with parent reference"
      # it "makes re-offer with amendment reference"
      # it "preserves the re-offer attributes"
      # it "adjusts the user balance and reserves"
    end

    context "with extra volume on the unfixed side" do
      # it "generates a re-offer"
      # it "makes re-offer with parent reference"
      # it "makes re-offer with amendment reference"
      # it "preserves the re-offer attributes"
      # it "adjusts the user balance and reserves"
    end

    context "with AON" do
      # it "doesn't match when two AON volume differ"
      # it "adjusts the BF offer"
      # it "adjusts the BU offer"
    end
  end
end

