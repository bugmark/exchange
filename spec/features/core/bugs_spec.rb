require 'rails_helper'

describe "Bugs" do

  let(:user) { FB.create(:user).user                                     }
  let(:repo) { FB.create(:repo).repo                                     }
  let(:issue)  { Issue.create(stm_repo_uuid: repo.uuid, type: "Issue::GitHub") }

  it "renders index", USE_VCR do
    hydrate(bug)
    visit "/core/bugs"
    expect(page).to_not be_nil
  end

  it "renders show", USE_VCR do
    hydrate(bug)
    visit "/core/bugs/#{bug.uuid}"
    expect(page).to_not be_nil
  end

  it "clicks thru to show", USE_VCR do
    hydrate(bug)
    visit "/core/bugs"
    click_on "bug.#{bug.id}"
    expect(page).to_not be_nil
  end

  it "creates an OBF", USE_VCR do
    login_as(user, :scope => :user)
    hydrate(bug)
    expect(Offer::Buy::Fixed.count).to eq(0)
    expect(Issue.count).to eq(1)

    visit "/core/bugs"
    click_on "fixed"
    click_on "Create"

    expect(Offer::Buy::Fixed.count).to eq(1)
  end

  it "creates a OBU", USE_VCR do
    login_as(user, :scope => :user)
    hydrate(bug)
    expect(Offer::Buy::Unfixed.count).to eq(0)
    expect(Issue.count).to eq(1)

    visit "/core/bugs"
    click_on "unfixed"
    click_on "Create"

    expect(Offer::Buy::Unfixed.count).to eq(1)
  end
end
