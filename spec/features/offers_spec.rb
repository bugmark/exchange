require 'rails_helper'

describe "Offers" do

  let(:ask) { FG.create(:ask).ask              }
  let(:bid) { FG.create(:bid).bid              }

  it "renders index (empty)" do
    visit "/offers"
    expect(page).to_not be_nil
  end

  it "renders index (with element)", USE_VCR do
    hydrate(ask, bid)
    visit "/offers"
    expect(page).to_not be_nil #
  end
end