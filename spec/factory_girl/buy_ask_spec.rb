require 'rails_helper'

RSpec.describe 'BuyAsk Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:buy_ask)
    expect(Offer.count).to eq(1)
  end
end
