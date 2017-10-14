require 'rails_helper'

RSpec.describe 'AskBuy Factory' do
  it "runs without params", USE_VCR do
    expect(Offer.count).to eq(0)
    FG.create(:ask_buy)
    expect(Offer.count).to eq(1)
  end
end
