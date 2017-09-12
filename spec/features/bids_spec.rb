require 'rails_helper'

describe "Bids" do

  let(:user)     { FG.create(:user).user              }
  let(:bid)      { FG.create(:bid).bid                }

  it "renders index" do
    visit "/bids"
    expect(page).to_not be_nil
  end

  it "renders show", USE_VCR do
    visit "/bids/#{bid.id}"
    expect(page).to_not be_nil
  end

  it "renders /new" do
    login_as user, :scope => :user

    visit "/bids/new"
    expect(page.body).to have_content("New Bid")
  end
end
