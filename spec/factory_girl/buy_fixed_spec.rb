require 'rails_helper'

RSpec.describe 'BuyFixed Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:buy_fixed) #
    expect(Offer.count).to eq(1)
  end

  it "has a default price and value", USE_VCR do
    result = FG.create(:buy_fixed)
    expect(result.price).to_not be_nil
    expect(result.volume).to_not be_nil
  end
end
