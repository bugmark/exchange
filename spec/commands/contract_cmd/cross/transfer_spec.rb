require 'rails_helper'

RSpec.describe ContractCmd::Cross::Transfer do

  include_context 'Integration Environment'

  let(:offer_su) { FG.create(:offer_su, price: 0.4).offer                   }
  let(:offer_bu) { FG.create(:offer_bu, user_id: usr1.id, price: 0.4).offer }
  let(:transfer) { klas.new(offer_su, :transfer)                            }
  let(:user) { FG.create(:user).user }
  let(:klas) { described_class }
  subject { klas.new(offer_su, :transfer) }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer }
    it { should respond_to :counters }
    it { should respond_to :type }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas }
    it "should be valid" do
      hydrate(offer_bu, transfer)
      expect(transfer).to be_valid
    end
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
    it 'detects a valid object' do
      hydrate(offer_bu)
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      hydrate(offer_bu)
      expect(Contract.count).to eq(0)
      subject.project
      expect(Contract.count).to eq(1)
    end

    it 'adjusts the user balance' do
      hydrate(offer_bu, offer_su)
      expect(usr1.token_available).to eq(96.0)
      subject.project
      usr1.reload
      expect(usr1.balance).to eq(96.0)
      expect(usr1.token_available).to eq(96.0)
    end

    it 'generates positions' do
      hydrate(offer_bu, offer_su)
      subject.project
      expect(Position.count).to eq(4)
    end

    it 'generates an escrow', :focus do
      hydrate(offer_bu, offer_su)
      subject.project
      expect(Escrow.count).to eq(2)
    end

    it 'generates an amendment' do
      hydrate(offer_bu, offer_su)
      subject.project
      expect(Amendment.count).to eq(2)
    end
  end

  describe "crossing", USE_VCR do
    let(:lcl_osf) { FG.create(:offer_sf).offer }

    context "with single bid" do
      it 'matches higher values' do
        hydrate(lcl_osf)
        FG.create(:offer_bf)
        expect(Position.count).to eq(2)
        klas.new(lcl_osf, :transfer).project
        expect(Offer.crossed.count).to eq(4)
        expect(Position.count).to eq(4)
      end

      it 'generates position ownership' do
        hydrate(lcl_osf)
        FG.create(:offer_bf)
        klas.new(lcl_osf, :transfer).project
        expect(Position.first.user_id).to_not be_nil
        expect(Position.last.user_id).to_not be_nil
      end

      it 'matches equal values' do
        FG.create(:offer_bu)
        klas.new(lcl_osf, :transfer).project
        expect(Position.count).to eq(2) #
      end

      it 'fails to match lower values' do
        FG.create(:offer_bu, price: 0.1, volume: 1)
        expect(Position.count).to eq(0)
        klas.new(lcl_osf, :transfer).project
        expect(Position.count).to eq(2)
      end
    end

    context "with multiple bids" do
      it 'matches higher value' do
        _bid1 = FG.create(:offer_bu, price: 0.5, volume: 10).offer
        _bid2 = FG.create(:offer_bu, price: 0.5, volume: 10).offer
        klas.new(lcl_osf, :transfer).project
        expect(Contract.count).to eq(1)
      end

      it 'matches equal value' do
        hydrate(lcl_osf)
        _bid1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _bid2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_osf, :transfer).project
        expect(Contract.count).to eq(1)
      end

      it 'fails to match lower value' do
        _bid1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _bid2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_osf, :transfer).project
        expect(Contract.count).to eq(1)
      end
    end

    context "with extra bids" do
      it 'does minimal matching', :focus do
        _bid1 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _bid2 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        _bid3 = FG.create(:offer_bu, price: 0.6, volume: 10).offer
        klas.new(lcl_osf, :transfer).project
        expect(Contract.count).to eq(1)
        expect(Offer.assigned.count).to eq(2)
        expect(Offer.unassigned.count).to eq(4)
      end
    end
  end

  # for transfers:
  # - sell offer prices specify a lower limit
  # - buy offer prices specify an upper limit
  describe "transfer price limits", USE_VCR do
    it "meets in the middle with sell offer" do
      hydrate(offer_su)   # 0.40
      _offer_buy = FG.create(:offer_bu, price: 0.5, volume: 10).offer
      klas.new(offer_su, :transfer).project
      escrow = Escrow.where(type: "Escrow::Transfer").first
      expect(Escrow.count).to eq(2)
      expect(escrow.unfixed_positions.first.price).to eq(0.45)
    end

    it "meets in middle with buy offer" do
      hydrate(offer_su)   # 0.40
      offer_buy = FG.create(:offer_bu, price: 0.5, volume: 10).offer
      _list = offer_buy.qualified_counteroffers(:transfer)
      klas.new(offer_buy, :transfer).project
      escrow = Escrow.where(type: "Escrow::Transfer").first
      expect(Escrow.count).to eq(2)
      expect(escrow.unfixed_positions.first.price).to eq(0.45)
    end

    it "generates nothing if no sell price match" do
      hydrate(offer_su)   # 0.40
      _offer_buy = FG.create(:offer_bu, price: 0.3, volume: 10).offer
      klas.new(offer_su, :transfer).project
      expect(Escrow.count).to eq(1)
    end

    it "generates nothing if no buy price match" do
      hydrate(offer_su)   # 0.40
      offer_buy = FG.create(:offer_bu, price: 0.3, volume: 10).offer
      klas.new(offer_buy, :transfer).project
      expect(Escrow.count).to eq(1)
    end
  end
end

