require 'rails_helper'

describe "OffersBu" do

  let(:user)     { FG.create(:user).user                    }
  let(:bid)      { FG.create(:offer_bu).offer                }

  it "renders index" do
    visit "/core/offers_bu"
    expect(page).to_not be_nil
  end
end
