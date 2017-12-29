require 'rails_helper'

describe "Issues" do

  let(:user) { FB.create(:user).user                                     }
  let(:repo) { FB.create(:repo).repo                                     }
  let(:bug)  { Bug.create(stm_repo_uuid: repo.uuid, type: "Bug::GitHub") }

  include_context 'Integration Environment'

  it "renders index", USE_VCR do
    hydrate(bug)
    visit "/docfix/issues"
    expect(page).to_not be_nil
  end

  it "renders show", USE_VCR do
    hydrate(bug)
    visit "/docfix/issues/#{bug.id}"
    expect(page).to_not be_nil #.
  end

  # it "generates an OBF", USE_VCR do
  #   login_as(usr1, :scope => :user)
  #   hydrate(bug)
  #   visit "/docfix/issues/#{bug.id}"
  #   click_on "BE THE FIRST TO INVEST"
  #   click_on "Buy Unfixed"
  #   expect(Offer.count).to eq(0)
  #   click_on "Create Offer"
  #   expect(page).to_not be_nil
  #   expect(Offer.count).to eq(1)
  # end

  # it "generates an OBU", USE_VCR do
  #   login_as(usr1, :scope => :user)
  #   hydrate(bug)
  #   visit "/docfix/issues/#{bug.id}"
  #   click_on "BE THE FIRST TO INVEST"
  #   click_on "Buy Fixed"
  #   expect(Offer.count).to eq(0)
  #   click_on "Create Offer"
  #   expect(page).to_not be_nil
  #   expect(Offer.count).to eq(1)
  # end
end
