require 'rails_helper'

RSpec.describe 'SellAsk Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:sell_fixed)
    expect(Offer.count).to eq(2)
  end

  it "generates the right class", USE_VCR do
    obj = FG.create(:sell_fixed).offer
    expect(obj).to be_a(Offer::Sell::Fixed)
  end
end
