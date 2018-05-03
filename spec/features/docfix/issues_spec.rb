require 'rails_helper'

describe "Issues", USE_VCR do

  let(:user)    { FB.create(:user).user                                               }
  let(:tracker) { FB.create(:gh_tracker).tracker                                      }
  let(:issue)   { Issue.create(stm_tracker_uuid: tracker.uuid, type: "Issue::GitHub") }

  include_context 'Integration Environment'

  it "renders index" do
    hydrate(issue)
    visit "/docfix/issues"
    expect(page).to_not be_nil
  end

  # it "renders show" do
  #   hydrate(issue)
  #   visit "/docfix/issues/#{issue.id}"
  #   expect(page).to_not be_nil
  # end

  # it "generates an OBF" do
  #   login_as(usr1, :scope => :user)
  #   hydrate(issue)
  #   visit "/docfix/issues/#{issue.id}"
  #   click_on "BE THE FIRST TO INVEST"
  #   click_on "Buy Unfixed"
  #   expect(Offer.count).to eq(0)
  #   click_on "Create Offer"
  #   expect(page).to_not be_nil
  #   expect(Offer.count).to eq(1)
  # end

  # it "generates an OBU" do
  #   login_as(usr1, :scope => :user)
  #   hydrate(issue)
  #   visit "/docfix/issues/#{issue.id}"
  #   click_on "BE THE FIRST TO INVEST"
  #   click_on "Buy Fixed"
  #   expect(Offer.count).to eq(0)
  #   click_on "Create Offer"
  #   expect(page).to_not be_nil
  #   expect(Offer.count).to eq(1)
  # end
end
