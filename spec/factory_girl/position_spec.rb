require 'rails_helper'

RSpec.describe 'Position Factory', USE_VCR do
  it "runs without params" do
    expect(Position.count).to eq(0)
    FG.create(:position)
    expect(Position.count).to eq(1)
  end

  it "gets the default side" do
    obj = FG.create(:position)
    expect(obj.side).to eq("unfixed")
  end

  it "creates a unfixed position" do
    obj = FG.create(:unfixed_position)
    expect(obj.side).to eq("unfixed")
  end

  it "creates an fixed position" do
    obj = FG.create(:fixed_position)
    expect(obj.side).to eq("fixed")
  end

  it "generates a crossed offer (F)" do
    obj = FG.create(:fixed_position)
    expect(obj.offer).to_not be_nil
    expect(obj.offer.status).to eq("crossed")
    expect(Position.count).to eq(1)
    expect(Offer.count).to eq(1)
  end

  it "has common ownership between the position and offer (F)" do
    obj = FG.create(:fixed_position)
    pusr = obj.user
    ousr = obj.offer.user
    expect(pusr).to eq(ousr)
    expect(Position.count).to eq(1)
    expect(Offer.count).to eq(1)
  end

  it "generates a crossed offer (U)" do
    obj = FG.create(:unfixed_position)
    expect(obj.offer).to_not be_nil
    expect(obj.offer.status).to eq("crossed")
    expect(Position.count).to eq(1)
    expect(Offer.count).to eq(1)
  end

  it "has common ownership between the position and offer (U)" do
    obj = FG.create(:unfixed_position)
    pusr = obj.user
    ousr = obj.offer.user
    expect(pusr).to eq(ousr)
    expect(Position.count).to eq(1)
    expect(Offer.count).to eq(1)
  end
end