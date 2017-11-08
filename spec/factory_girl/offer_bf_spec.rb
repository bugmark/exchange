require 'rails_helper'

RSpec.describe 'OfferBF Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:offer_bf) #
    expect(Offer.count).to eq(1)
  end

  it "has a default price and value", USE_VCR do
    result = FG.create(:offer_bf)
    expect(result.price).to_not be_nil
    expect(result.volume).to_not be_nil
  end
end
