require 'rails_helper'

RSpec.describe ContractCmd::Cross::Transfer do

  include_context 'Integration Environment'

  let(:offer_su) { FBX.offer_su(osu: {price: 0.4}).offer                        }
  let(:offer_bu) { FB.create(:offer_bu, user_uuid: usr1.uuid, price: 0.4).offer }
  let(:transfer) { klas.new(offer_su, :transfer)                                }
  let(:user)     { FB.create(:user).user }
  let(:klas)     { described_class       }
  subject        { transfer              }

  describe "Attributes", USE_VCR do
    it { should respond_to :offer }
  end

  describe "Object Existence", USE_VCR do
    it { should be_a klas }
    it "should be valid" do
      hydrate(offer_bu, transfer)
      expect(transfer).to be_valid
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
    it 'detects an invalid object' do
      hydrate(offer_su, offer_bu)
      subject.project
      expect(subject).to be_valid
    end

    it 'gets the right object count' do
      hydrate(offer_su, offer_bu)
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to eq(1)
      subject.project
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to eq(2)
    end
  end

  describe "#project - valid subject", USE_VCR do
    it 'detects a valid object' do
      hydrate(offer_bu)
      subject.project
      expect(subject).to be_valid
    end
  end

  # for transfers:
  # - sell offer prices specify a lower limit
  # - buy offer prices specify an upper limit
  #
  # describe "transfer price limits", USE_VCR do
  #   it "meets in the middle with sell offer" do
  #     hydrate(offer_su)   # 0.40
  #     _offer_buy = FB.create(:offer_bu, price: 0.5, volume: 10).offer
  #     klas.new(offer_su, :transfer).project
  #     escrow = Escrow.where(type: "Escrow::Transfer").first
  #     expect(Escrow.count).to eq(2)
  #     expect(escrow.unfixed_positions.first.price).to eq(0.45)
  #   end
  #
  #   it "meets in middle with buy offer" do
  #     hydrate(offer_su)   # 0.40
  #     offer_buy = FB.create(:offer_bu, price: 0.5, volume: 10).offer
  #     _list = offer_buy.qualified_counteroffers(:transfer)
  #     klas.new(offer_buy, :transfer).project
  #     escrow = Escrow.where(type: "Escrow::Transfer").first
  #     expect(Escrow.count).to eq(2)
  #     expect(escrow.unfixed_positions.first.price).to eq(0.45)
  #   end
  #
  #   it "generates nothing if no sell price match" do
  #     hydrate(offer_su)   # 0.40
  #     _offer_buy = FB.create(:offer_bu, price: 0.3, volume: 10).offer
  #     klas.new(offer_su, :transfer).project
  #     expect(Escrow.count).to eq(1)
  #   end
  #
  #   it "generates nothing if no buy price match" do
  #     hydrate(offer_su)   # 0.40
  #     offer_buy = FB.create(:offer_bu, price: 0.3, volume: 10).offer
  #     klas.new(offer_buy, :transfer).project
  #     expect(Escrow.count).to eq(1)
  #   end
  # end
end

