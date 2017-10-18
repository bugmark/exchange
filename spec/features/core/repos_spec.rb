require 'rails_helper'

describe "Repos", USE_VCR do

  include_context 'Integration Environment'

  before(:each) { hydrate(repo1) }

  it "renders index" do
    visit "/core/repos"
    expect(page).to_not be_nil #.
  end

  it "renders show" do
    visit "/core/repos/#{repo1.id}"
    expect(page).to_not be_nil
  end

  # it "click thru to new" do
  #   visit "/core/repos"
  #   click_on "Add New GitHub Repo"
  #   expect(page).to_not be_nil
  # end

  it "clicks thru to show" do
    visit "/core/repos"
    click_on "rep.#{repo1.id}"
    expect(page).to_not be_nil
  end #

  it "click thru to bug index" do
    hydrate(bug1)
    visit "/core/repos"
    find('.buglink').click
    expect(page).to_not be_nil
  end

  it "creates an ask", USE_VCR do
    login_as(usr1, :scope => :user)
    hydrate(bug1)
    expect(Offer::Buy::Ask.count).to eq(0)
    expect(Bug.count).to eq(1)

    visit "/core/repos"
    click_on "Ask"
    click_on "Create Ask"

    expect(Offer::Buy::Ask.count).to eq(1)
  end

  it "creates a bid", USE_VCR do
    login_as(usr1, :scope => :user)
    hydrate(bug1)
    expect(Offer::Buy::Bid.count).to eq(0)
    expect(Bug.count).to eq(1)

    visit "/core/repos"
    click_on "Bid"
    click_on "Create Bid"

    expect(Offer::Buy::Bid.count).to eq(1)
  end
end
