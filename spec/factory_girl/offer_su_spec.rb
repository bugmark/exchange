require 'rails_helper'

RSpec.describe 'OfferSU Factory', USE_VCR do
  it "runs without params", :focus do
    expect(Offer.count).to eq(0)
    FG.create(:offer_su)
    expect(Offer.count).to eq(3)
  end

  it "generates the right class" do
    obj = FG.create(:offer_su).offer
    expect(obj).to be_a(Offer::Sell::Unfixed)
  end

  it "generates a position" do
    obj = FG.create(:offer_su).offer
    expect(obj.salable_position).to_not be_nil
  end

  it "generates an buy offer" do
    obj = FG.create(:offer_su).offer
    expect(obj.salable_position.offer).to_not be_nil
    expect(obj.salable_position.offer.status).to eq('crossed')
  end

  it "generates a suite of elements" do
    FG.create(:offer_sf)
    expect(Position.count).to eq(2)
    expect(Escrow.count).to eq(1)
    expect(Offer.count).to eq(3)
    expect(Contract.count).to eq(1)
  end

  it "has common ownership between the position and offer" do
    obj = FG.create(:unfixed_position)
    pusr = obj.user
    ousr = obj.offer.user
    expect(pusr).to eq(ousr)
  end
end
