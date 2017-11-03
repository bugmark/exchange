require 'rails_helper'

describe "Offers" do

  let(:ask) { FG.create(:buy_fixed).offer          }
  let(:bid) { FG.create(:buy_unfixed).offer          }

  it "renders index (empty)" do
    visit "/core/offers"
    expect(page).to_not be_nil
  end

  it "renders index (with element)", USE_VCR do
    hydrate(ask, bid)
    visit "/core/offers"
    expect(page).to_not be_nil #.
  end
end