require 'rails_helper'

describe "Issues", USE_VCR do

  let(:user)  { FB.create(:user).user                                         }
  let(:repo)  { FB.create(:repo).repo                                         }
  let(:issue) { Issue.create(stm_repo_uuid: repo.uuid, type: "Issue::GitHub") }

  it "renders index" do
    hydrate(issue)
    visit "/core/issues"
    expect(page).to_not be_nil
  end

  it "renders show" do
    hydrate(issue)
    visit "/core/issues/#{issue.uuid}"
    expect(page).to_not be_nil
  end

  it "clicks thru to show" do
    hydrate(issue)
    visit "/core/issues"
    click_on "issue.#{issue.id}"
    expect(page).to_not be_nil
  end

  it "creates an OBF" do
    login_as(user, :scope => :user)
    hydrate(issue)
    expect(Offer::Buy::Fixed.count).to eq(0)
    expect(Issue.count).to eq(1)

    visit "/core/issues"
    click_on "fixed"
    click_on "Create"

    expect(Offer::Buy::Fixed.count).to eq(1)
  end

  it "creates a OBU" do
    login_as(user, :scope => :user)
    hydrate(issue)
    expect(Offer::Buy::Unfixed.count).to eq(0)
    expect(Issue.count).to eq(1)

    visit "/core/issues"
    click_on "unfixed"
    click_on "Create"

    expect(Offer::Buy::Unfixed.count).to eq(1)
  end
end
