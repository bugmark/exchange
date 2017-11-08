require 'rails_helper'

describe "OffersBf" do

  let(:user)     { FG.create(:user).user              }
  let(:ask)      { FG.create(:offer_bf).offer          }

  it "renders index" do
    visit "/core/offers_bf"
    expect(page).to_not be_nil
  end
end