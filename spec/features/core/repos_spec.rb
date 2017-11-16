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

  it "creates an OBF", USE_VCR do
    login_as(usr1, :scope => :user)
    hydrate(bug1)
    expect(Offer::Buy::Fixed.count).to eq(0)
    expect(Bug.count).to eq(1)

    visit "/core/repos"
    click_on "fixed"
    click_on "Create"

    expect(Offer::Buy::Fixed.count).to eq(1)
  end

  it "creates an OBU", USE_VCR do
    login_as(usr1, :scope => :user)
    hydrate(bug1)
    expect(Offer::Buy::Unfixed.count).to eq(0)
    expect(Bug.count).to eq(1)

    visit "/core/repos"
    click_on "unfixed"
    click_on "Create"

    expect(Offer::Buy::Unfixed.count).to eq(1)
  end
end
