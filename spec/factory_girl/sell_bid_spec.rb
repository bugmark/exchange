require 'rails_helper'

RSpec.describe 'SellBid Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:sell_unfixed)
    expect(Offer.count).to eq(2)
  end

  it "generates the right class", USE_VCR do
    obj = FG.create(:sell_unfixed).offer
    expect(obj).to be_a(Offer::Sell::Unfixed)
  end
end
