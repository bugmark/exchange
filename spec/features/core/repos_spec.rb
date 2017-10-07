require 'rails_helper'

describe "Repos", USE_VCR do

  include_context 'Integration Environment'

  before(:each) { hydrate(repo1) }

  it "renders index" do
    visit "/core/repos"
    expect(page).to_not be_nil
  end

  it "renders show" do
    visit "/core/repos/#{repo1.id}"
    expect(page).to_not be_nil
  end

  it "click thru to new" do
    visit "/core/repos"
    click_on "Add New GitHub Repo"
    expect(page).to_not be_nil
  end

  it "clicks thru to show" do
    visit "/core/repos"
    click_on "rep.#{repo1.id}"
    expect(page).to_not be_nil
  end

  it "click thru to bug index" do
    hydrate(bug1)
    visit "/core/repos"
    find('.buglink').click
    expect(page).to_not be_nil
  end

  it "takes a bid", USE_VCR do
    login_as(usr1, :scope => :user)
    hydrate(bug1)
    expect(Bid.count).to eq(0)
    expect(Bug.count).to eq(1)

    visit "/core/bugs"
    click_on "Bid"
    click_on "Create Create"

    expect(Bid.count).to eq(1)
  end
end
