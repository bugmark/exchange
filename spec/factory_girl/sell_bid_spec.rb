require 'rails_helper'

RSpec.describe 'SellBid Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:sell_bid)
    expect(Offer.count).to eq(2)
  end
end
