require 'rails_helper'

describe "OffersBf" do

  let(:user)     { FB.create(:user).user              }
  let(:ask)      { FB.create(:offer_bf).offer          }

  it "renders index" do
    visit "/core/offers_bf"
    expect(page).to_not be_nil
  end
end