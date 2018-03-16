require 'rails_helper'

describe "OffersBu" do

  let(:user)     { FB.create(:user).user                    }
  let(:bid)      { FB.create(:offer_bu).offer                }

  it "renders index" do
    visit "/core/offers_bu"
    expect(page).to_not be_nil
  end
end
