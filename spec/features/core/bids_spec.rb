require 'rails_helper'

describe "Bids" do

  let(:user)     { FG.create(:user).user                    }
  let(:bid)      { FG.create(:buy_bid).offer                }

  it "renders index" do
    visit "/core/bids"
    expect(page).to_not be_nil
  end

  it "renders /new" do
    login_as user, :scope => :user

    visit "/core/bids/new"
    expect(page.body).to have_content("New Bid")
  end
end
