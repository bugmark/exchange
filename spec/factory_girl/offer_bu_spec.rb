require 'rails_helper'

RSpec.describe 'OfferBU Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:offer_bu)
    expect(Offer.count).to eq(1) #
  end
end

