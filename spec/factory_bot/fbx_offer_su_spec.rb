require 'rails_helper'

RSpec.describe 'FbxOfferSf', USE_VCR do

  describe "offer_sf" do
    it "runs without params" do
      expect(Offer.count).to    eq(0)
      expect(Contract.count).to eq(0)
      expect(Escrow.count).to   eq(0)
      expect(Position.count).to eq(0)
      result = FBX.offer_su
      expect(result).to be_present
      expect(Offer.count).to    eq(3)
      expect(Contract.count).to eq(1)
      expect(Escrow.count).to   eq(1)
      expect(Position.count).to eq(2)
    end

    it "generates the right class" do
      obj = FBX.offer_su.offer
      expect(obj).to be_a(Offer::Sell::Unfixed)
    end

    it "generates a position" do
      obj = FBX.offer_su.offer
      expect(obj.salable_position).to_not be_nil
    end

    it "generates an buy offer" do
      obj = FBX.offer_su.offer
      expect(obj.salable_position.offer).to_not be_nil
      expect(obj.salable_position.offer.status).to eq('crossed')
    end

    it "has common ownership between the position and offer" do
      obj = FBX.offer_su.offer
      ousr = obj.user
      pusr = obj.salable_position.user
      expect(pusr).to eq(ousr)
    end

    it "has a default sale price" do
      obj = FBX.offer_su.offer
      expect(obj.price).to eq(0.6)
    end

    it "can sets the sale price" do
      opts = {osu: {price: 0.2}}
      obj = FBX.offer_su(opts)
      expect(obj.offer.price).to eq(0.2)
    end
  end
end
