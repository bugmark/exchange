require 'rails_helper'

RSpec.describe ContractCmd::Cross::Transfer do

  include_context 'Integration Environment'

  let(:offer_su) { FBX.offer_su(osu: {price: 0.4}).offer                        }
  let(:offer_bu) { FB.create(:offer_bu, user_uuid: usr1.uuid, price: 0.4).offer }
  let(:transfer) { klas.new(offer_su, :transfer)                                }
  let(:user)     { FB.create(:user).user }
  let(:klas)     { described_class       }
  subject        { transfer              }

  describe "Attributes" do
    it { should respond_to :offer }
  end

  describe "Object Existence" do
    it { should be_a klas }
    it "should be valid" do
      hydrate(offer_bu, transfer)
      expect(transfer).to be_valid
    end
  end

  describe "Delegated Object" do
    it 'has a present Offer' do
      expect(subject.offer).to be_present
    end

    it 'has a Offer with the right class' do
      expect(subject.offer).to be_a(Offer)
    end
  end

  describe "#project - basics" do
    it 'gets the right object count' do
      hydrate(offer_su, offer_bu)
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to eq(1)
      expect(Amendment.count).to eq(1)
      expect(User.count).to eq(3)
      expect(Offer.count).to eq(4)
      expect(Offer.open.count).to eq(2)
      subject.project
      expect(User.count).to eq(3)
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to eq(1)
      expect(Amendment.count).to eq(2)
      expect(Offer.count).to eq(4)
      expect(Offer.open.count).to eq(0)
    end
  end

  describe "#project - valid subject" do
    before(:each) { hydrate(offer_su, offer_bu) }

    # it 'detects a valid object' do
    #   subject.project
    #   expect(subject).to be_valid
    # end

    # it 'sets the contract status' do
    #   subject.project
    #   expect(subject.contract.status).to eq("open")
    # end

    # when the sell offer is made:
    # - sellers reserve should not change
    # - sellers balance should not change
    # when the transfer cross is made:
    # - funds transfers from buyer to seller
    # - buyer account is decremented
    # it 'adjusts the user balance' do
    #   usr_su = offer_su.user
    #   usr_bu = offer_bu.user
    #   expect(usr_su.balance).to eq(994.0)
    #   expect(usr_su.token_reserve).to eq(0.0)
    #   expect(usr_bu.balance).to eq(1000.0)
    #   expect(usr_bu.token_reserve).to eq(4.0)
    #   expect(Offer.open.count).to eq(2)
    #   subject.project
    #   usr_su.reload ; usr_bu.reload
    #   expect(usr_su.balance).to eq(990.0)
    #   expect(usr_su.token_reserve).to eq(0.0)
    #   expect(usr_bu.balance).to eq(996.0)
    #   expect(usr_bu.token_reserve).to eq(0.0)
    #   expect(Offer.open.count).to eq(0)
    # end
  end

  # for transfers:
  # - sell offer prices specify a lower limit #
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

